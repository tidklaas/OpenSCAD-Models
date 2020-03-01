#! /bin/sh

# Quick'n'dirty script to generate STLs and PNGs for all possible module
# configurations for a given layout.

# Default layout
leds_pm=60
num_x=8
num_y=8
wall_h=15

while [ -n "$1" ]
do
    case "$1" in
        -x)
            num_x=$2
            shift 2
            ;;
        -y)
            num_y=$2
            shift 2
            ;;
        -h)
            wall_h=$2
            shift 2
            ;;
        -l)
            leds_pm=$2
            shift 2
            ;;
        -*)
            echo "Unknown option: $1"
            exit 1
            ;;
        *)
            break;
            ;;
    esac
done

# First non-option argument is the SCAD file
scad_file=$1;
base_file=$(basename "$scad_file" .scad)

for top in "0" "1"
do
    for right in "0" "1"
    do
        for bottom in "0" "1"
        do
            for left in "0" "1"
            do
                openscad -D "num_x=${num_x}" -D "num_y=${num_y}" \
                    -D "leds_pm=${leds_pm}" -D "wall_h=${wall_h}" \
                    -D "borders=[${top}, ${right}, ${bottom}, ${left}]" \
                    -o "${base_file}_${num_x}x${num_y}_${leds_pm}_${top}${right}${bottom}${left}.stl" \
                    "$scad_file"
                openscad -D "num_x=${num_x}" -D "num_y=${num_y}" \
                    -D "leds_pm=${leds_pm}" -D "wall_h=${wall_h}" \
                    -D "borders=[${top}, ${right}, ${bottom}, ${left}]" \
                    --render  --autocenter --viewall --projection=ortho \
                    --imgsize=1024,1024 --colorscheme=Metallic \
                    -o "${base_file}_${num_x}x${num_y}_${leds_pm}_${top}${right}${bottom}${left}.png" \
                    "$scad_file"
            done
        done
    done
done
