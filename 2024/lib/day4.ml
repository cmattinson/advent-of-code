open! Core

let possible_directions = [| -1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1 |]

exception Exit

let find_xmas grid x y direction =
  let dx, dy = direction in
  let word = [| 'X'; 'M'; 'A'; 'S' |] in
  Array.for_alli word ~f:(fun i c ->
    let y' = y + (dy * i) in
    let x' = x + (dx * i) in
    if x' >= 0 && x' < Array.length grid && y' >= 0 && y' < Array.length grid.(0)
    then Char.equal grid.(y').(x') c
    else false)
;;

let find_mas_cross grid x y =
  try
    if
      Char.equal grid.(y).(x) 'A'
      && Int.between ~low:1 ~high:(Array.length grid - 2) y
      && Int.between ~low:1 ~high:(Array.length grid.(0) - 2) x
    then (
      let left_diag = Printf.sprintf "%c%c" grid.(y - 1).(x - 1) grid.(y + 1).(x + 1) in
      let right_diag = Printf.sprintf "%c%c" grid.(y - 1).(x + 1) grid.(y + 1).(x - 1) in
      if
        (String.equal left_diag "MS" || String.equal left_diag "SM")
        && (String.equal right_diag "MS" || String.equal right_diag "SM")
      then true
      else false)
    else false
  with
  | Exit -> false
;;

let part1 grid =
  let count = ref 0 in
  for y = 0 to Array.length grid - 1 do
    for x = 0 to Array.length grid.(0) - 1 do
      Array.iter possible_directions ~f:(fun direction ->
        if find_xmas grid x y direction then count := !count + 1)
    done
  done;
  Printf.printf "Part 1 - %d\n" !count
;;

let part2 grid =
  let count = ref 0 in
  for y = 0 to Array.length grid - 1 do
    for x = 0 to Array.length grid.(0) - 1 do
      if find_mas_cross grid x y then count := !count + 1
    done
  done;
  Printf.printf "Part 2 - %d\n" !count
;;

let solve input =
  let grid =
    input |> String.split_lines |> List.to_array |> Array.map ~f:String.to_array
  in
  part1 grid;
  part2 grid
;;
