open Core
open Aoc

let%expect_test "2024 Day 1 - part 1" =
  try
    {|3   4
4   3
2   5
1   3
3   9
3   3|}
    |> String.split_lines
    |> Day1.solve_part_1
    |> Printf.printf "%d\n";
    [%expect {| 11 |}]
  with
  | Failure msg -> Stdio.print_endline msg
;;

let%expect_test "2024 Day 1 - part 2" =
  try
    {|3   4
4   3
2   5
1   3
3   9
3   3|}
    |> String.split_lines
    |> Day1.solve_part_2
    |> Printf.printf "%d\n";
    [%expect {| 31 |}]
  with
  | Failure msg -> Stdio.print_endline msg
;;
