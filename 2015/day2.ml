open Day2_lib
open! Core

let split_line line = String.split line ~on:'x' |> List.to_array

let box_of_line (split : string array) =
  create_box
    (Int.of_string (Array.get split 0))
    (Int.of_string (Array.get split 1))
    (Int.of_string (Array.get split 2))
;;

let solve_part1 input =
  input
  |> List.fold ~init:0 ~f:(fun accum line ->
    let split = split_line line in
    let box = box_of_line split in
    accum + Day2_lib.required_area box)
;;

let solve_part2 input =
  input
  |> List.fold ~init:0 ~f:(fun accum line ->
    let split = split_line line in
    let box = box_of_line split in
    accum + Day2_lib.ribbon_amount box)
;;

let () =
  let input = In_channel.with_file "inputs/day2.txt" ~f:In_channel.input_lines in
  Printf.printf "%d\n" (input |> solve_part1);
  Printf.printf "%d\n" (input |> solve_part2)
;;
