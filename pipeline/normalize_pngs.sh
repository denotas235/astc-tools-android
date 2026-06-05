#!/usr/bin/env bash
set -e

pip install pillow >/dev/null 2>&1 || true

find sorted/ -name "*.png" | while read f; do
  python3 - <<PY
from PIL import Image
import sys

path = sys.argv[1]
try:
    img = Image.open(path).convert("RGBA")
    img.save(path)
    print("OK:", path)
except Exception as e:
    print("ERROR:", path, e)
PY
  "$f"
done
