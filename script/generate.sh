#!/bin/sh

cd ..

for file in ./svgs/*; do
    file_name=$(basename "$file" .svg)
    case "$file_name" in
        frame_*)
            for frame_file in "$file"/*; do
                frame_file_name=$(basename "$frame_file" .svg)
                printf "\033[34m\ninkscape output frame file: %s\n%s -> %s\n\033[0m" "$frame_file_name" "$frame_file" "./${frame_file_name}.png"
                inkscape "$frame_file" -w 32 -h 32 -o "./${frame_file_name}.png"
            done
            ;;
        *)
            printf "\033[34m\ninkscape output file: %s\n%s -> %s\n\033[0m" "$file_name" "$file" "./${file_name}.png"
            inkscape "$file" -w 32 -h 32 -o "./${file_name}.png"
            ;;
    esac
done

for cursor_file in ./*.cursor; do
    cursor_file_name=$(basename "$cursor_file" .cursor)
    printf "\033[34m\nxcursorgen file: %s\n%s -> %s\n\033[0m" $cursor_file_name "./${cursor_file_name}.cursor" "./cursors/${cursor_file_name}"
    xcursorgen "./${cursor_file_name}.cursor" "./cursors/${cursor_file_name}"
done

printf "\033[34m\nenter dir: cursors/\n\033[0m"
cd cursors/

link_file() {
    target="$1"
    linkname="$2"
    printf "\033[34m\nlink: %s -> %s\n\033[0m" "$linkname" "$target"
    ln -s "$linkname" "$target"
}

link_file "00000000000000020006000e7e9ffc3f" "progress"
link_file "00008160000006810000408080010102" "ns-resize"
link_file "028006030e0e7ebffc7f7070c0600140" "ew-resize"
link_file "03b6e0fcb3499374a867c041f52298f0" "not-allowed"
link_file "0426c94ea35c87780ff01dc239897213" "wait"
link_file "043a9f68147c53184671403ffa811cc5" "col-resize"
link_file "048008013003cff3c00c801001200000" "vertical-text"
link_file "08e8e1c95fe2fc01f976f1e063a24ccd" "progress"
link_file "08ffe1cb5fe6fc01f906f1c063814ccf" "copy"
link_file "08ffe1e65f80fcfdf9fff11263e74c48" "context-menu"
link_file "1081e37283d90000800003c07f3ef6bf" "copy"
link_file "14fef782d02440884392942c11205230" "col-resize"
link_file "2870a09082c103050810ffdffffe0204" "row-resize"
link_file "38c5dff7c7b8962045400281044508d2" "nwse-resize"
link_file "3ecb610c1bf2410f44200f48c40d3599" "progress"
link_file "50585d75b494802d0151028115016902" "nesw-resize"
link_file "5c6cd98b3f3ebcb1f9c7f1c204630408" "help"
link_file "6407b0e94181790501fd1e167b474872" "copy"
link_file "9116a3ea924ed2162ecab71ba103b17f" "progress"
link_file "all-scroll" "fleur"
link_file "arrow" "left_ptr"
link_file "b66166c04f8c3109214a4fbd64a50fc8" "copy"
link_file "based_arrow_down" "sb_v_double_arrow"
link_file "based_arrow_up" "sb_v_double_arrow"
link_file "bottom_side" "sb_v_double_arrow"
link_file "cell" "plus"
link_file "clock" "watch"
link_file "col-resize" "sb_h_double_arrow"
link_file "d9ce0ab605698f320427677b458ad60b" "help"
link_file "default" "left_ptr"
link_file "double_arrow" "sb_v_double_arrow"
link_file "draft_large" "right_ptr"
link_file "draft_small" "right_ptr"
link_file "draped_box" "dotbox"
link_file "e-resize" "right_side"
link_file "ew-resize" "sb_h_double_arrow"
link_file "hand1" "hand"
link_file "hand2" "hand"
link_file "help" "question_arrow"
link_file "icon" "dotbox"
link_file "left_side" "sb_h_double_arrow"
link_file "n-resize" "top_side"
link_file "ne-resize" "top_right_corner"
link_file "nesw-resize" "bottom_left_corner"
link_file "ns-resize" "sb_v_double_arrow"
link_file "nw-resize" "top_left_corner"
link_file "nwse-resize" "bottom_right_corner"
link_file "pointer" "hand"
link_file "progress" "left_ptr_watch"
link_file "right_side" "sb_h_double_arrow"
link_file "row-resize" "sb_v_double_arrow"
link_file "s-resize" "bottom_side"
link_file "se-resize" "bottom_right_corner"
link_file "sizing" "bottom_right_corner"
link_file "sw-resize" "bottom_left_corner"
link_file "target" "dotbox"
link_file "tcross" "cross"
link_file "text" "xterm"
link_file "top_left_arrow" "left_ptr"
link_file "top_side" "sb_v_double_arrow"
link_file "up-arrow" "center_ptr"
link_file "w-resize" "left_side"
link_file "wait" "watch"
