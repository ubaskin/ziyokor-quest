# Ziyokor Quest — Bilim orollari 🏝

2–4 sinf o'quvchilari uchun 3D matematik sarguzasht o'yini.
**Jonli:** https://ubaskin.github.io/ziyokor-quest/

## O'yin

5 ta uchuvchi orol: Amallar → Geometriya → Ulushlar → Masalalar → Bilim minorasi.
Har orol darvozasida 4 ta savol (jami 20). To'g'ri javob → ko'prik quriladi.
Yulduzlar: 1-urinish 3⭐, 2-urinish 2⭐, 3-urinish 1⭐ (maks. 60⭐).
Savollar har o'yinda YANGI generatsiya bo'ladi (takror yo'q) — sinfga mos qiyinlik (2/3/4-sinf tanlovi).

## Texnik

- **Dvijok:** Three.js 0.160 (CDN), bitta `index.html`, build yo'q
- **Art:** barcha rasmlar Higgsfield AI (z_image + nano_banana_2), `gen_assets.sh`
  - qahramon/maskot: yashil fon → PIL chroma-key (`assets/final/*.png`)
- **Ovoz:** edge-tts `uz-UZ-MadinaNeural` (audio/*.mp3) + WebAudio chimes
- **Leaderboard:** Firebase RTDB `ziyokor-qabul` → `quest/scores` (REST, SDK'siz)
  - rules: `Tahlillar/ziyokor-qabul/database.rules.json` (bir marta yozish, o'qish ochiq)
- **Deploy:** GitHub Pages, repo `ubaskin/ziyokor-quest`, main branch

## Yangilash

```bash
cd Tahlillar/ziyokor-quest
# o'zgartir → commit → push (Pages avtomatik yangilanadi ~1 min)
git add -A && git commit -m "..." && git push
```

QR kod: `qr_ziyokor_quest.png` (chop etib maktabga osish mumkin).
