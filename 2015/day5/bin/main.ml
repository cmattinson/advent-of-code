open Day5
open! Core

let solve_part_1 input =
  input
  |> List.fold ~init:0 ~f:(fun accum str ->
    if P1.is_nice_string str then accum + 1 else accum)
;;

let solve_part_2 input =
  input
  |> List.fold ~init:0 ~f:(fun accum str ->
    if P2.is_nice_string str then accum + 1 else accum)
;;

let () =
  let input = In_channel.with_file "day5.txt" ~f:In_channel.input_lines in
  Printf.printf "Part 1 - %d\n" (input |> solve_part_1);
  Printf.printf "Part 2 - %d\n" (input |> solve_part_2)
;;
