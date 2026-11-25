const fs = require('node:fs');
const path = require('node:path');

const cacheDir = process.argv[2] || process.env.GSMA_CACHE_DIR;
if (!cacheDir) {
  console.error('Butuh folder cache GSM Arena');
  process.exit(1);
}

const output = {};
for (const file of fs.readdirSync(cacheDir).filter(name => /^cache-.+\.json$/.test(name))) {
  const data = JSON.parse(fs.readFileSync(path.join(cacheDir, file), 'utf8'));
  const brand = data.key || file.replace(/^cache-/, '').replace(/\.json$/, '');
  for (const [key, phone] of Object.entries(data.index || {})) {
    if (key.startsWith('title:')) {
      const alias = key.slice(6);
      if (alias && !output[alias]) output[alias] = Object.assign({}, phone, { brand });
      continue;
    }
    if (!output[key]) output[key] = Object.assign({}, phone, { brand });
  }
}

const target = path.join(__dirname, '..', 'data', 'gsma-index.json');
fs.mkdirSync(path.dirname(target), { recursive: true });
fs.writeFileSync(target, JSON.stringify(output, null, 2) + '\n');
console.log('GSM Arena index entries:', Object.keys(output).length);
