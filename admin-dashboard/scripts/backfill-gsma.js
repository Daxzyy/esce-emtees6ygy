const axios = require('axios');
const { resolveDevice, CHECK_TTL } = require('./gsma-resolver');

const ROOT = process.env.FIREBASE_ROOT || 'https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app';
const AUTH = process.env.FIREBASE_AUTH_HEADER || 'Basic YWRtaW46YWRtaW4=';

async function main() {
  const response = await axios.get(ROOT + '/devices.json', {
    timeout: 20000,
    headers: { Authorization: AUTH }
  });
  const rows = Object.entries(response.data || {}).map(([code, value]) =>
    Object.assign({}, value && typeof value === 'object' ? value : {}, { code })
  );

  let resolved = 0;
  let notFound = 0;
  let skipped = 0;

  for (const row of rows) {
    const checked = Number(row.gsmaCheckedAt || 0);
    if ((row.gsmaName && row.gsmaImage) || (checked && Date.now() - checked < CHECK_TTL)) {
      skipped++;
      continue;
    }
    try {
      const result = await resolveDevice(row);
      if (result.found) resolved++;
      else notFound++;
      console.log(row.code, row.model || '-', '=>', result.name || 'fallback ID');
    } catch (error) {
      notFound++;
      console.error(row.code, row.model || '-', '=>', error.message);
    }
  }

  console.log(JSON.stringify({ devices: rows.length, resolved, notFound, skipped }));
}

main().catch(error => {
  console.error(error.message);
  process.exit(1);
});
