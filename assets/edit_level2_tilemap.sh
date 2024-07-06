#!/bin/bash

# Read the current level2.tilemap file
input_file="level2.tilemap"
output_file="level2_updated.tilemap"

# Initialize variables
tilesource="/assets/tilesource.tilesource"
layer_id="background"
z_index=0.0
is_visible=1

# Define the new number of rows and columns
new_rows=10
new_columns=10

# Define the tile indices for the ground and obstacles
ground_tile=0
obstacle_tile=1

# Create the new tilemap content
echo "tilemap {" > $output_file
echo "  tilesource: \"$tilesource\"" >> $output_file
echo "  layers {" >> $output_file
echo "    id: \"$layer_id\"" >> $output_file
echo "    z: $z_index" >> $output_file
echo "    is_visible: $is_visible" >> $output_file

# Generate the new rows and columns with appropriate tile indices
for ((y=0; y<$new_rows; y++)); do
  for ((x=0; x<$new_columns; x++)); do
    if (( (x + y) % 5 == 0 )); then
      tile=$obstacle_tile
    else
      tile=$ground_tile
    fi
    echo "    cell {" >> $output_file
    echo "      x: $x" >> $output_file
    echo "      y: $y" >> $output_file
    echo "      tile: $tile" >> $output_file
    echo "      h_flip: 0" >> $output_file
    echo "      v_flip: 0" >> $output_file
    echo "    }" >> $output_file
  done
done

# Close the tilemap structure
echo "  }" >> $output_file
echo "}" >> $output_file

# Replace the old tilemap file with the new one
mv $output_file $input_file

echo "level2.tilemap has been updated successfully."
