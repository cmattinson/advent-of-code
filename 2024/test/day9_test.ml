open Core
open Aoc

let%expect_test "2024 Day 9 - calculate_checksum 2333133121414131402" =
  "2333133121414131402"
  |> Day9.parse_blocks
  |> Day9.flatten
  |> Day9.compact_blocks
  |> Day9.calculate_checksum
  |> Printf.printf "%d\n";
  [%expect {| 1928 |}]
;;

let%expect_test "2024 Day 9 - compact_whole_files 2333133121414131402" =
  "2333133121414131402"
  |> Day9.parse_blocks
  |> Day9.compact_whole_files
  |> Day9.calculate_checksum
  |> Printf.printf "%d\n";
  [%expect {| 2858 |}]
;;
