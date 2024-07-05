#!/bin/bash

# Validate tile indices in level2.tilemap against tilesource.tilesource

# Path to the level2.tilemap file
TILEMAP_FILE="/home/ubuntu/PlantsVsZombiesDefold/assets/level2.tilemap"

# Path to the tilesource.tilesource file
TILESOURCE_FILE="/home/ubuntu/PlantsVsZombiesDefold/assets/tilesource.tilesource"

# Extract the tile dimensions from the tilesource file
TILE_WIDTH=$(grep -oP 'tile_width: \K\d+' "$TILESOURCE_FILE")
TILE_HEIGHT=$(grep -oP 'tile_height: \K\d+' "$TILESOURCE_FILE")

# Get the dimensions of the tileset image
IMAGE_DIMENSIONS=$(identify -format "%w %h" "/home/ubuntu/PlantsVsZombiesDefold/assets/tiles.png")
IMAGE_WIDTH=$(echo $IMAGE_DIMENSIONS | cut -d' ' -f1)
IMAGE_HEIGHT=$(echo $IMAGE_DIMENSIONS | cut -d' ' -f2)

# Calculate the total number of tiles
NUM_TILES=$(( (IMAGE_WIDTH / TILE_WIDTH) * (IMAGE_HEIGHT / TILE_HEIGHT) ))

# Read the tile indices from the level2.tilemap file
TILE_INDICES=$(grep -oP 'data: \K.*' "$TILEMAP_FILE" | tr ',' '\n')

# Validate each tile index
for INDEX in $TILE_INDICES; do
  if [ "$INDEX" -ge "$NUM_TILES" ]; then
    echo "Invalid tile index: $INDEX"
    exit 1
  fi
done

echo "All tile indices are valid."
