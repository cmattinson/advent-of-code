open Core
open Day1_lib

let solve_part1 input = input |> get_floor |> Printf.sprintf "%d\n"
let solve_part2 input = input |> basement_instruction |> Printf.sprintf "%d\n"

let () =
  let input = In_channel.read_all "inputs/day1.txt" in
  Printf.printf "Part 1 - %s" (input |> solve_part1);
  Printf.printf "Part 2 - %s" (input |> solve_part2)
;;
