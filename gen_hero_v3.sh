#!/bin/bash
# Ziyokor Quest — kechki konveyer: teksturali qahramon + rigging + animatsiyalar + 3D buyumlar
# Chiqish: design/hero-v3/
set -u
cd "$(dirname "$0")"
OUT=design/hero-v3
mkdir -p "$OUT"
LOG="$OUT/pipeline.log"
exec >>"$LOG" 2>&1
echo "=== START $(date) ==="

HERO_IMG_JOB="a77cefa6-8515-4446-966c-24a4e3d7f02b"   # kristall ritsar konsept (nano_banana_2 job)

extract_glb() { # stdin: json -> birinchi .glb url
  python3 -c "
import sys, json
raw=sys.stdin.read()
try: d=json.loads(raw)
except Exception: print(''); sys.exit()
def walk(o):
    if isinstance(o,dict):
        for k,v in o.items():
            if isinstance(v,str) and v.startswith('http') and '.glb' in v: yield v
            else: yield from walk(v)
    elif isinstance(o,list):
        for i in o: yield from walk(i)
urls=list(walk(d))
print(urls[0] if urls else '')
"
}

# --- 1) Teksturali qahramon (image_to_3d, should_texture=true) ---
echo "[1] hero textured image_to_3d..."
HJSON=$(higgsfield generate create image_to_3d --image "$HERO_IMG_JOB" --should_texture true --wait --wait-timeout 30m --json)
echo "$HJSON" > "$OUT/hero_tex_job.json"
HERO_URL=$(echo "$HJSON" | extract_glb)
echo "hero textured url: $HERO_URL"
if [ -z "$HERO_URL" ]; then echo "FAIL hero texture"; else
  curl -sL "$HERO_URL" -o "$OUT/hero_tex.glb" && echo "OK hero_tex.glb ($(stat -f%z "$OUT/hero_tex.glb") b)"
fi

# --- 2) Buyumlar parallel (qilich, kitob-qalqon) ---
prop() { # name imgpath
  local name="$1" img="$2"
  echo "[prop] $name..."
  local js
  js=$(higgsfield generate create image_to_3d --image "$img" --should_texture true --wait --wait-timeout 30m --json)
  echo "$js" > "$OUT/${name}_job.json"
  local url
  url=$(echo "$js" | extract_glb)
  if [ -n "$url" ]; then curl -sL "$url" -o "$OUT/${name}.glb" && echo "OK ${name}.glb"; else echo "FAIL $name"; fi
}
prop sword  design/hero-v2/prop_sword.png &
prop shield design/hero-v2/prop_shield.png &

# --- 3) Rigging + animatsiyalar (teksturali model ustidan) ---
if [ -n "$HERO_URL" ]; then
  anim() { # action_id name
    local id="$1" name="$2"
    echo "[anim] $name (action_id=$id)..."
    local js
    js=$(higgsfield generate create 3d_rigging --model_url "$HERO_URL" --enable_animation true --animation_action_id "$id" --wait --wait-timeout 30m --json)
    echo "$js" > "$OUT/anim_${name}_job.json"
    local url
    url=$(echo "$js" | extract_glb)
    # model_url kirish ham .glb — chiqishni ajratamiz: kirishdan farqli birinchi url
    url=$(echo "$js" | python3 -c "
import sys, json
raw=sys.stdin.read()
try: d=json.loads(raw)
except Exception: print(''); sys.exit()
def walk(o):
    if isinstance(o,dict):
        for k,v in o.items():
            if isinstance(v,str) and v.startswith('http') and '.glb' in v: yield v
            else: yield from walk(v)
    elif isinstance(o,list):
        for i in o: yield from walk(i)
urls=[u for u in walk(d) if u != '$HERO_URL']
print(urls[0] if urls else '')
")
    if [ -n "$url" ]; then curl -sL "$url" -o "$OUT/hero_${name}.glb" && echo "OK hero_${name}.glb"; else echo "FAIL anim $name"; fi
  }
  anim 0 idle &
  anim 1 walk &
  anim 4 attack &
fi

wait
echo "=== DONE $(date) ==="
ls -la "$OUT"
