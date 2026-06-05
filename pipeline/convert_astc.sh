#!/usr/bin/env bash
set -e

SRC="$1"
OUT="$2"
ASTCENC="$(pwd)/astcenc"

mkdir -p "$OUT/assets/minecraft/textures/gui"
mkdir -p "$OUT/assets/minecraft/textures/block"
mkdir -p "$OUT/assets/minecraft/textures/item"
mkdir -p "$OUT/assets/minecraft/textures/environment"
mkdir -p "$OUT/assets/minecraft/textures/entity"

# GUI → 4x4
find "$SRC/gui" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/gui/}"
  out="$OUT/assets/minecraft/textures/gui/${rel%.png}.astc"
  mkdir -p "$(dirname "$out")"
  "$ASTCENC" -c "$f" "$out" 4x4 -medium
done

# Blocks → 6x6
find "$SRC/block" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/block/}"
  out="$OUT/assets/minecraft/textures/block/${rel%.png}.astc"
  mkdir -p "$(dirname "$out")"
  "$ASTCENC" -c "$f" "$out" 6x6 -medium
done

# Items → 4x4
find "$SRC/item" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/item/}"
  out="$OUT/assets/minecraft/textures/item/${rel%.png}.astc"
  mkdir -p "$(dirname "$out")"
  "$ASTCENC" -c "$f" "$out" 4x4 -medium
done

# Environment → 8x8
find "$SRC/environment" -type f -name "*.png" | while read -r f; do
  rel="${f#$SRC/environment/}"
  out="$OUT/assets/minecraft/textures/environment/${rel%.png}.astc"
  mkdir -p "$(dirname "$out")"
  "$ASTCENC" -c "$f" "$out" 8x8 -medium
done

# Skins → 4x4
find "$SRC/skin" -type f -name "*.png" | while read -r f; do
  base="$(basename "$f")"
  out="$OUT/assets/minecraft/textures/entity/${base%.png}.astc"
  mkdir -p "$(dirname "$out")"
  "$ASTCENC" -c "$f" "$out" 4x4 -medium
done
