open! Core
open Day6_lib

let () =
  let grid = Array.make_matrix ~dimx:1000 ~dimy:1000 false in
  let input = In_channel.with_file "inputs/day6.txt" ~f:In_channel.input_lines in
  input |> List.iter ~f:(fun line -> Instruction.of_string line |> act_on_lights grid);
  let count = grid |> count_lights in
  Printf.printf "%d\n" !count
;;
