#!/usr/bin/env bash
set -e

SRC="$1"
OUT="$2"

ASTCENC="$(realpath "$(dirname "$0")/../astcenc")"

mkdir -p "$OUT/assets/minecraft/textures/gui"
mkdir -p "$OUT/assets/minecraft/textures/block"
mkdir -p "$OUT/assets/minecraft/textures/item"
mkdir -p "$OUT/assets/minecraft/textures/environment"
mkdir -p "$OUT/assets/minecraft/textures/entity"

convert() {
  local input="$1"
  local output="$2"
  local block="$3"

  mkdir -p "$(dirname "$output")"
  "$ASTCENC" -cl "$input" "$output" "$block" -medium
}

# GUI → 4x4
find "$SRC/gui" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/gui/}"
  convert "$f" "$OUT/assets/minecraft/textures/gui/${rel%.png}.astc" "4x4"
done

# Blocks → 6x6
find "$SRC/block" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/block/}"
  convert "$f" "$OUT/assets/minecraft/textures/block/${rel%.png}.astc" "6x6"
done

# Items → 4x4
find "$SRC/item" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/item/}"
  convert "$f" "$OUT/assets/minecraft/textures/item/${rel%.png}.astc" "4x4"
done

# Environment → 8x8
find "$SRC/environment" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/environment/}"
  convert "$f" "$OUT/assets/minecraft/textures/environment/${rel%.png}.astc" "8x8"
done

# Skins → 4x4
find "$SRC/skin" -type f -name "*.png" | while read -r f; do
  base="$(basename "$f")"
  convert "$f" "$OUT/assets/minecraft/textures/entity/${base%.png}.astc" "4x4"
done
