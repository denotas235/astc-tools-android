#!/usr/bin/env bash
set -e

RP="$1"
OUT="$2"

cat > "$RP/pack.mcmeta" <<EOF2
{
  "pack": {
    "pack_format": 18,
    "description": "AstcNexus ASTC Pack for Minecraft 1.21.11"
  }
}
EOF2

cd "$RP"
zip -r "../$OUT" .
