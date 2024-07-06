open Core

let digits_only str = str |> String.filter ~f:Char.is_digit

let get_first_digit str =
  let filtered_string = str |> digits_only in
  String.get filtered_string 0
;;

let get_last_digit str =
  let filtered_string = str |> digits_only |> String.rev in
  String.get filtered_string 0
;;

let solve_part_1 =
  let input = Advent.read_lines "inputs/day1.txt" in
  input
  |> List.map ~f:(fun string ->
    let first = get_first_digit string in
    let last = get_last_digit string in
    Printf.sprintf "%c%c" first last)
  |> List.fold ~init:0 ~f:(fun accum string -> accum + Int.of_string string)
;;

let () =
  let solution1 = solve_part_1 in
  Printf.printf "Part 1 - %d\n" solution1
;;
