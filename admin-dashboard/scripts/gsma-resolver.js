const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('node:fs');
const path = require('node:path');

const BASE = 'https://m.gsmarena.com';
const ROOT = process.env.FIREBASE_ROOT || 'https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app';
const AUTH = process.env.FIREBASE_AUTH_HEADER || 'Basic YWRtaW46YWRtaW4=';
const UA = 'Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';
const INDEX_FILE = path.join(__dirname, '..', 'data', 'gsma-index.json');
const CHECK_TTL = 7 * 24 * 60 * 60 * 1000;
const MAX_DETAILS = Number(process.env.GSMA_MAX_DETAILS || 1200);

const http = axios.create({
  baseURL: BASE,
  timeout: 30000,
  headers: { 'User-Agent': UA, 'Accept': 'text/html,application/xhtml+xml', 'Accept-Language': 'en-US,en;q=0.9' }
});
const firebase = axios.create({
  baseURL: ROOT,
  timeout: 20000,
  headers: { 'Authorization': AUTH }
});

const sleep = ms => new Promise(resolve => setTimeout(resolve, ms));
const normalize = value => String(value ?? '').toUpperCase().replace(/[^A-Z0-9]/g, '');
const brandKey = value => String(value ?? '').toLowerCase().replace(/[^a-z0-9]/g, '');

let staticIndex = null;
let brands = null;
let brandsAt = 0;
const inflight = new Map();

async function getHtml(target, attempt = 0) {
  try {
    const response = await http.get(target);
    const html = typeof response.data === 'string' ? response.data : String(response.data ?? '');
    if (/GSMArena Turnstile check|cf-turnstile/.test(html)) throw new Error('GSMArena meminta verifikasi');
    return html;
  } catch (error) {
    const status = error.response?.status;
    if (attempt < 2 && (status >= 500 || status === 429 || error.code === 'ECONNABORTED')) {
      await sleep(800 * (attempt + 1));
      return getHtml(target, attempt + 1);
    }
    throw error;
  }
}

async function firebasePatch(target, body) {
  await firebase.patch(target + '.json', body);
}

function loadIndex() {
  if (staticIndex) return staticIndex;
  try {
    staticIndex = JSON.parse(fs.readFileSync(INDEX_FILE, 'utf8'));
  } catch (error) {
    staticIndex = {};
  }
  return staticIndex;
}

async function loadBrands() {
  if (brands && Date.now() - brandsAt < 7 * 24 * 60 * 60 * 1000) return brands;
  const $ = cheerio.load(await getHtml('/makers.php3'));
  const found = {};
  $('a[href]').each((_, element) => {
    const href = $(element).attr('href') || '';
    const match = href.match(/^([a-z0-9_&]+)-phones-(\d+)\.php$/i);
    const name = $(element).text().trim();
    if (!match || !name) return;
    found[brandKey(name)] = { name, slug: match[1], id: match[2] };
  });
  if (!Object.keys(found).length) throw new Error('Daftar merek GSMArena kosong');
  brands = found;
  brandsAt = Date.now();
  return brands;
}

function resolveBrand(maker) {
  const all = brands || {};
  const key = brandKey(maker);
  if (all[key]) return all[key];
  for (const [brandId, brand] of Object.entries(all)) {
    if (key && (brandId.includes(key) || key.includes(brandId))) return brand;
  }
  return null;
}

function parsePhoneLinks(html) {
  const $ = cheerio.load(html);
  const links = [];
  $('#list-brands a[href], .list-brands a[href]').each((_, element) => {
    const href = $(element).attr('href') || '';
    const label = $(element).text().trim();
    if (!label || !/-\d+\.php$/i.test(href)) return;
    if (/-phones-|php3|compare|news|review/i.test(href)) return;
    links.push({ label, href });
  });
  return links;
}

async function getPhoneLinks(brand) {
  const mainHtml = await getHtml('/' + brand.slug + '-phones-' + brand.id + '.php');
  const links = parsePhoneLinks(mainHtml);
  const $ = cheerio.load(mainHtml);
  let lastPage = 1;
  const pagePattern = new RegExp(brand.slug + '-phones-f-' + brand.id + '-0-p(\\d+)\\.php', 'i');
  $('a[href]').each((_, element) => {
    const match = ($(element).attr('href') || '').match(pagePattern);
    if (match) lastPage = Math.max(lastPage, Number(match[1]));
  });

  for (let page = 2; page <= lastPage; page++) {
    await sleep(120);
    const html = await getHtml('/' + brand.slug + '-phones-f-' + brand.id + '-0-p' + page + '.php');
    links.push(...parsePhoneLinks(html));
  }

  const seenUrls = new Set();
  return links.filter(link => {
    const url = new URL(link.href, BASE).href;
    if (seenUrls.has(url)) return false;
    seenUrls.add(url);
    link.url = url;
    return true;
  });
}

async function fetchPhone(link) {
  const html = await getHtml(link.url);
  const $ = cheerio.load(html);
  const name = $('h1').first().text().trim() || link.label;
  let image = $('.specs-cp-pic-rating img').attr('src')
    || $('img[src*="/vv/bigpic/"]').first().attr('src')
    || $('img[src*="/vv/pics/"]').first().attr('src')
    || null;
  if (image && image.startsWith('//')) image = 'https:' + image;
  else if (image && image.startsWith('/')) image = BASE + image;

  const models = $('[data-spec="models"]').first().text()
    .split(/[,;/|\n]+/)
    .map(part => part.trim())
    .filter(Boolean);

  return { name, image, url: link.url, models };
}

function matchScore(phone, query) {
  if (phone.models.some(model => normalize(model) === query)) return 3;
  if (query.length >= 4 && phone.models.some(model => normalize(model).includes(query))) return 2;
  if (query.length >= 4 && normalize(phone.name).includes(query)) return 1;
  return 0;
}

async function deepResolve(model, maker) {
  const query = normalize(model);
  await loadBrands();
  const brand = resolveBrand(maker);
  if (!brand || !query) return null;

  const links = await getPhoneLinks(brand);
  let best = null;
  let checked = 0;
  for (const link of links) {
    if (checked >= MAX_DETAILS) break;
    await sleep(120);
    const phone = await fetchPhone(link);
    checked++;
    const score = matchScore(phone, query);
    if (score === 3) return phone;
    if (score && !best) best = phone;
  }
  return best;
}

function normalizeResult(entry) {
  if (!entry || typeof entry !== 'object') return null;
  return {
    found: entry.found !== false,
    name: entry.name || null,
    image: entry.image || null,
    url: entry.url || null,
    models: Array.isArray(entry.models) ? entry.models : []
  };
}

function candidateQueries(model) {
  const text = String(model ?? '').trim();
  const parts = text.split(/\s+/);
  return [normalize(text), normalize(parts[parts.length - 1])].filter(Boolean);
}

async function resolveModel(model, maker) {
  const queries = candidateQueries(model);
  const query = queries[0];
  if (!query) return { found: false, name: null, image: null, url: null, models: [] };
  if (inflight.has(query)) return inflight.get(query);

  const job = (async () => {
    const index = loadIndex();
    let phone = null;
    for (const candidate of queries) {
      phone = normalizeResult(index[candidate]);
      if (phone && phone.name) break;
    }
    if (!phone || !phone.name) phone = await deepResolve(queries[queries.length - 1], maker);
    return phone && phone.name
      ? Object.assign({}, phone, { found: true })
      : { found: false, name: null, image: null, url: null, models: [] };
  })();

  inflight.set(query, job);
  try {
    return await job;
  } finally {
    inflight.delete(query);
  }
}

async function resolveDevice(record) {
  const model = String(record.model ?? '').trim();
  const maker = String(record.manufacturer ?? '').trim();
  const code = String(record.code ?? '').trim();
  const result = await resolveModel(model, maker);
  if (!code) return result;

  if (result.found) {
    await firebasePatch('/devices/' + code, {
      gsmaName: result.name,
      gsmaImage: result.image,
      gsmaUrl: result.url,
      gsmaModels: result.models,
      gsmaResolvedAt: Date.now(),
      gsmaCheckedAt: Date.now()
    });
  } else {
    await firebasePatch('/devices/' + code, { gsmaCheckedAt: Date.now(), gsmaMissing: true });
  }
  return result;
}

module.exports = { resolveDevice, resolveModel, normalize, CHECK_TTL };
