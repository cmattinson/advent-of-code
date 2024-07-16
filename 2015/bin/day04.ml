open Day04_lib
open! Core

let solve_part_1 key = find_lowest_num key ~pattern:"00000"
let solve_part_2 key = find_lowest_num key ~pattern:"000000"

let () =
  let key = "yzbqklnj" in
  Printf.printf "Part 1 - %d\n" (solve_part_1 key);
  Printf.printf "Part 2 - %d\n" (solve_part_2 key)
;;
