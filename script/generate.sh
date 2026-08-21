#!/bin/sh

for cmd in inkscape xcursorgen; do
    if ! command -v "$cmd" >/dev/null; then
        printf "\033[31mError: Required command '%s' not found.\n\033[0m" "$cmd" >&2
        exit 127
    fi
done

SCRIPT_DIR=$(CDPATH="" cd -- "$(dirname -- "$0")" && pwd)
printf "\033[34mScript Dir: %s\n\033[0m" "$SCRIPT_DIR"
if ! cd "$SCRIPT_DIR/../"; then
    printf "\033[31mError: %s/../ cannot be entered.\n\033[0m" "$SCRIPT_DIR" >&2
    exit 1
fi

[ -d ./pngs ]  && rm -rf ./pngs
[ -d ./build ] && rm -rf ./build
mkdir -p ./pngs ./build/cursors

to_png() {
    svg_path=$1
    png_path=$2
    size=$3
    if ! cmd_out=$(inkscape "$svg_path" -w "$size" -h "$size" -o "$png_path" 2>&1) || [ ! -e "$png_path" ]; then
        [ ! -e "$png_path" ] && cmd_out="The PNG file was not created."
        printf "\033[31mError: Converting from %s -> %s failed.\n%s" "$svg_path" "$png_path" "$cmd_out" >&2
        exit 2
    fi
}

SVG_SUM=$(find ./svgs/ -type f -name "*.svg" | wc -l)
PNG_SUM=$((SVG_SUM * 4))
PROGRESS=0
for size in 32 48 64 96; do
    for file in ./svgs/*; do
        file_name=$(basename "$file" .svg)
        case "$file_name" in
            frame_*)
                for frame_file in "$file"/*.svg; do
                    PROGRESS=$((PROGRESS + 1))
                    frame_file_name=$(basename "$frame_file" .svg)
                    png_path="./pngs/${frame_file_name}_$size.png"
                    printf "\033[34m%d / %d\nInkscape output frame file: %s\n%s -> %s (size: %dpx)\n\033[0m" $PROGRESS $PNG_SUM "$frame_file_name" "$frame_file" "$png_path" "$size"
                    to_png "$frame_file" "$png_path" "$size"
                done
                ;;
            *)
                PROGRESS=$((PROGRESS + 1))
                png_path="./pngs/${file_name}_$size.png"
                printf "\033[34m%d / %d\nInkscape output file: %s\n%s -> %s (size: %dpx)\n\033[0m" $PROGRESS $PNG_SUM "$file_name" "$file" "$png_path" "$size"
                to_png "$file" "$png_path" "$size"
                ;;
        esac
    done
done

XCURSORGEN_SUM=$(find ./xcursorgen/ -type f -name "*.cursor" | wc -l)
PROGRESS=0
for cursor_file in ./xcursorgen/*.cursor; do
    PROGRESS=$((PROGRESS + 1))
    cursor_file_name=$(basename "$cursor_file" .cursor)
    cursor_file_path="./xcursorgen/${cursor_file_name}.cursor"
    out_file_path="./build/cursors/${cursor_file_name}"
    printf "\033[34m%s / %s\nXcursorgen file: %s\n%s -> %s\n\033[0m" $PROGRESS "$XCURSORGEN_SUM" "$cursor_file_name" "$cursor_file_name" "$out_file_path"
    if ! cmd_out=$(xcursorgen "$cursor_file_path" "$out_file_path"); then
        printf "\033[31mError: Xcursorgen from %s -> %s failed.\n%s" "$cursor_file_path" "$out_file_path" "$cmd_out" >&2
        exit 2
    fi
done

cp ./index.theme ./build/
cp ./LICENSE     ./build/

printf "\033[34m\nEnter dir: ./build/cursors/\n\033[0m"
if ! cd "$SCRIPT_DIR/../build/cursors/"; then
    printf "\033[31mError: %s/../build/cursors/ cannot be entered.\n\033[0m" "$SCRIPT_DIR" >&2
    exit 1
fi

cursor_alias() {
    cursor="$1"
    target="$2"
    printf "\033[34m\nAlias: %s = %s\n\033[0m" "$cursor" "$target"
    ln -sf "$target" "$cursor"
}

cursor_alias "00000000000000020006000e7e9ffc3f" "PROGRESS"
cursor_alias "00008160000006810000408080010102" "ns-resize"
cursor_alias "028006030e0e7ebffc7f7070c0600140" "ew-resize"
cursor_alias "03b6e0fcb3499374a867c041f52298f0" "not-allowed"
cursor_alias "0426c94ea35c87780ff01dc239897213" "wait"
cursor_alias "043a9f68147c53184671403ffa811cc5" "col-resize"
cursor_alias "048008013003cff3c00c801001200000" "vertical-text"
cursor_alias "08e8e1c95fe2fc01f976f1e063a24ccd" "PROGRESS"
cursor_alias "08ffe1cb5fe6fc01f906f1c063814ccf" "copy"
cursor_alias "08ffe1e65f80fcfdf9fff11263e74c48" "context-menu"
cursor_alias "1081e37283d90000800003c07f3ef6bf" "copy"
cursor_alias "14fef782d02440884392942c11205230" "col-resize"
cursor_alias "2870a09082c103050810ffdffffe0204" "row-resize"
cursor_alias "38c5dff7c7b8962045400281044508d2" "nwse-resize"
cursor_alias "3ecb610c1bf2410f44200f48c40d3599" "PROGRESS"
cursor_alias "50585d75b494802d0151028115016902" "nesw-resize"
cursor_alias "5c6cd98b3f3ebcb1f9c7f1c204630408" "help"
cursor_alias "6407b0e94181790501fd1e167b474872" "copy"
cursor_alias "9116a3ea924ed2162ecab71ba103b17f" "PROGRESS"
cursor_alias "all-scroll"                       "fleur"
cursor_alias "arrow"                            "left_ptr"
cursor_alias "b66166c04f8c3109214a4fbd64a50fc8" "copy"
cursor_alias "based_arrow_down"                 "sb_v_double_arrow"
cursor_alias "based_arrow_up"                   "sb_v_double_arrow"
cursor_alias "bottom_side"                      "sb_v_double_arrow"
cursor_alias "cell"                             "plus"
cursor_alias "clock"                            "watch"
cursor_alias "col-resize"                       "sb_h_double_arrow"
cursor_alias "d9ce0ab605698f320427677b458ad60b" "help"
cursor_alias "default"                          "left_ptr"
cursor_alias "double_arrow"                     "sb_v_double_arrow"
cursor_alias "draft_large"                      "right_ptr"
cursor_alias "draft_small"                      "right_ptr"
cursor_alias "draped_box"                       "dotbox"
cursor_alias "e-resize"                         "right_side"
cursor_alias "ew-resize"                        "sb_h_double_arrow"
cursor_alias "hand1"                            "hand"
cursor_alias "hand2"                            "hand"
cursor_alias "help"                             "question_arrow"
cursor_alias "icon"                             "dotbox"
cursor_alias "left_side"                        "sb_h_double_arrow"
cursor_alias "n-resize"                         "top_side"
cursor_alias "ne-resize"                        "top_right_corner"
cursor_alias "nesw-resize"                      "bottom_left_corner"
cursor_alias "ns-resize"                        "sb_v_double_arrow"
cursor_alias "nw-resize"                        "top_left_corner"
cursor_alias "nwse-resize"                      "bottom_right_corner"
cursor_alias "pointer"                          "hand"
cursor_alias "PROGRESS"                         "left_ptr_watch"
cursor_alias "right_side"                       "sb_h_double_arrow"
cursor_alias "row-resize"                       "sb_v_double_arrow"
cursor_alias "s-resize"                         "bottom_side"
cursor_alias "se-resize"                        "bottom_right_corner"
cursor_alias "sizing"                           "bottom_right_corner"
cursor_alias "sw-resize"                        "bottom_left_corner"
cursor_alias "target"                           "dotbox"
cursor_alias "tcross"                           "cross"
cursor_alias "text"                             "xterm"
cursor_alias "top_left_arrow"                   "left_ptr"
cursor_alias "top_side"                         "sb_v_double_arrow"
cursor_alias "up-arrow"                         "center_ptr"
cursor_alias "w-resize"                         "left_side"
cursor_alias "wait"                             "watch"
