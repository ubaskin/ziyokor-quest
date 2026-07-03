import { chromium } from '/Users/ubaskin/.openclaw/workspace/dashboard/node_modules/.pnpm/playwright@1.58.2/node_modules/playwright/index.mjs';
import http from 'http';
import fs from 'fs';
import path from 'path';

const DIR = '/tmp/hero_turntable';
const FRAMES = path.join(DIR, 'frames');
fs.mkdirSync(FRAMES, { recursive: true });

// tiny static server (GLBs need http, not file://)
const server = http.createServer((req, res) => {
  const p = path.join(DIR, decodeURIComponent(req.url === '/' ? '/index.html' : req.url));
  if (!fs.existsSync(p)) { res.writeHead(404); return res.end(); }
  const ext = path.extname(p);
  res.writeHead(200, { 'content-type': ext === '.html' ? 'text/html' : ext === '.glb' ? 'model/gltf-binary' : 'application/octet-stream' });
  fs.createReadStream(p).pipe(res);
});
await new Promise(r => server.listen(8931, r));

const browser = await chromium.launch({ executablePath: '/Users/ubaskin/Library/Caches/ms-playwright/chromium_headless_shell-1217/chrome-headless-shell-mac-arm64/chrome-headless-shell',
  args: ['--use-gl=angle', '--use-angle=swiftshader', '--enable-unsafe-swiftshader', '--ignore-gpu-blocklist'] });
const page = await browser.newPage({ viewport: { width: 720, height: 720 } });
page.on('pageerror', e => console.error('PAGEERROR', e.message));
await page.goto('http://127.0.0.1:8931/');
await page.waitForFunction('window.ready === true', { timeout: 60000 });

const canvas = page.locator('canvas');
let i = 0, done = false;
while (!done) {
  await canvas.screenshot({ path: path.join(FRAMES, `f${String(i).padStart(4, '0')}.png`) });
  done = await page.evaluate('window.step()');
  i++;
  if (i > 400) break;
}
console.log('frames:', i);
await browser.close();
server.close();
