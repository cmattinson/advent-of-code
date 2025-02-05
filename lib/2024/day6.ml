open Core

type direction =
  | Up
  | Down
  | Left
  | Right

type location =
  { x : int
  ; y : int
  ; direction : direction
  }

module CoordinateSet = struct
  module T = struct
    type t = int * int [@@deriving compare, sexp]
  end

  include T
  include Comparator.Make (T)
end

let get_location_grid input =
  input
  |> List.to_array
  |> Array.map ~f:(fun chars -> String.to_list chars |> List.to_array)
;;

let location_opt x y direction = Some { x; y; direction }

let find_starting_location grid =
  let rows = Array.length grid in
  let rec iterate_rows i =
    if i < rows
    then (
      let cols = Array.length grid.(i) in
      let rec iterate_cols j =
        if j < cols
        then (
          match grid.(i).(j) with
          | '^' -> location_opt j i Up
          | '<' -> location_opt j i Left
          | '>' -> location_opt j i Right
          | 'v' -> location_opt j i Down
          | _ -> iterate_cols (j + 1))
        else iterate_rows (i + 1)
      in
      iterate_cols 0)
    else None
  in
  iterate_rows 0
;;

let step location =
  match location.direction with
  | Up -> { location with y = location.y - 1 }
  | Right -> { location with x = location.x + 1 }
  | Down -> { location with y = location.y + 1 }
  | Left -> { location with x = location.x - 1 }
;;

let rotate location =
  match location.direction with
  | Up -> Right
  | Right -> Down
  | Down -> Left
  | Left -> Up
;;

let walk grid start =
  let rec walk_grid coordinates location =
    let stepped = step location in
    let step_char = grid.(stepped.y).(stepped.x) in
    try
      match step_char with
      | '#' -> walk_grid coordinates { location with direction = rotate location }
      | _ -> walk_grid (Set.add coordinates (stepped.x, stepped.y)) (step location)
    with
    | _ -> Set.add coordinates (stepped.x, stepped.y)
  in
  let visited = Set.empty (module CoordinateSet) in
  let count = walk_grid (Set.add visited (start.x, start.y)) start in
  count
;;

let solve_part_1 grid start =
  let result = walk grid start in
  Printf.printf "Part 1 - %d\n" (Set.length result)
;;

let solve input =
  let grid = input |> get_location_grid in
  let start = find_starting_location grid in
  match start with
  | Some loc -> solve_part_1 grid loc
  | None -> Stdio.print_endline "Failed to find starting location"
;;
