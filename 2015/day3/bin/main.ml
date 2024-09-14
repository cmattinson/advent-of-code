open Day3
open! Core

let solve_part1 input = input |> String.to_list |> unique_houses
let solve_part2 input = input |> String.to_list |> unique_houses_robo

let () =
  let input = In_channel.read_all "day3.txt" in
  Printf.printf "Part 1 - %d\n" (input |> solve_part1);
  Printf.printf "Part 2 - %d\n" (input |> solve_part2)
;;
