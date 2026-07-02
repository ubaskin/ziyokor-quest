# Ziyokor Quest — Bilim orollari 🏝

2–4 sinf o'quvchilari uchun 3D matematik sarguzasht o'yini.
**Jonli:** https://ubaskin.github.io/ziyokor-quest/

## O'yin

5 ta uchuvchi orol: Amallar → Geometriya → Ulushlar → Masalalar → Bilim minorasi.
Har orol darvozasida 4 ta savol (jami 20). To'g'ri javob → ko'prik quriladi.
Yulduzlar: 1-urinish 3⭐, 2-urinish 2⭐, 3-urinish 1⭐ (maks. 60⭐).
Savollar har o'yinda YANGI generatsiya bo'ladi (takror yo'q) — sinfga mos qiyinlik (2/3/4-sinf tanlovi).

## Jang prototipi (fight.html)

**Jonli:** https://ubaskin.github.io/ziyokor-quest/fight.html
Kristall Ritsar × Tuman Soyasi: strelka/WASD — yurish, SPACE/⚔️ — zarba.
Qilich 3 zarbaga yetadi; tugasa misol yechib to'ldiriladi (to'g'ri javob = 🌟 2× zarba).
Hikoya: `design/story_sinopsis.md` (5 bob, Chalkash sehrgari).

## Qahramon (hero-v3, 2026-07-02)

- Konsept: Higgsfield nano_banana_2 → `design/hero-v2/concept_*.png`
- 3D: `image_to_3d --should_texture true` → rigging (`3d_rigging`, action 0/1/4 = idle/walk/attack)
- Konveyer: `gen_hero_v3.sh` → `design/hero-v3/` (xom fayllar)
- Optimallash: gltf-transform — tekstura webp 1024 (10MB→2MB), walk/attack anim-only (31/53KB)
- Qilich/kitob-qalqon: `assets/final/prop_{sword,shield}.glb`, suyakka biriktiriladi (RightHand/LeftForeArm)

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
