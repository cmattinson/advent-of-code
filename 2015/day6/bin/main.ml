open! Core
open Day6

let solve_part_1 input =
  let grid = Array.make_matrix ~dimx:1000 ~dimy:1000 false in
  input |> List.iter ~f:(fun line -> Instruction.of_string line |> P1.act_on_lights grid);
  let count = grid |> P1.count_lights in
  !count
;;

let solve_part_2 input =
  let grid = Array.make_matrix ~dimx:1000 ~dimy:1000 0 in
  input |> List.iter ~f:(fun line -> Instruction.of_string line |> P2.act_on_lights grid);
  let count = grid |> P2.count_lights in
  !count
;;

let () =
  let input = In_channel.with_file "day6.txt" ~f:In_channel.input_lines in
  Printf.printf "Part 1 - %d\n" (input |> solve_part_1);
  Printf.printf "Part 2 - %d\n" (input |> solve_part_2)
;;
