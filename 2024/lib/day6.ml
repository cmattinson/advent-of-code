open Core

type direction =
  | Up
  | Down
  | Left
  | Right
[@@deriving compare, sexp]

type location =
  { x : int
  ; y : int
  ; direction : direction
  }
[@@deriving compare, sexp]

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

let find_starting_location grid =
  let rows = Array.length grid in
  let rec iterate_rows y =
    if y < rows
    then (
      let cols = Array.length grid.(y) in
      let rec iterate_cols x =
        if x < cols
        then (
          match grid.(y).(x) with
          | '^' -> Some { x; y; direction = Up }
          | _ -> iterate_cols (x + 1))
        else iterate_rows (y + 1)
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

let occupied_count grid start =
  let rec walk_grid coordinates location =
    let next = step location
    and height = Array.length grid
    and width = Array.length grid.(location.y) in
    if next.y >= height || next.x >= width
    then coordinates
    else (
      let step_char = grid.(next.y).(next.x) in
      match step_char with
      | '#' -> walk_grid coordinates { location with direction = rotate location }
      | _ -> walk_grid (Set.add coordinates (next.x, next.y)) (step location))
  in
  let visited = [ start.x, start.y ] |> Set.of_list (module CoordinateSet) in
  Set.length (walk_grid visited start)
;;

let solve_part_1 grid start =
  let result = occupied_count grid start in
  Printf.printf "Part 1 - %d\n" result
;;

let solve input =
  let grid = input |> get_location_grid in
  let start = find_starting_location grid in
  match start with
  | Some loc -> solve_part_1 grid loc
  | None -> Stdio.print_endline "Failed to find starting location"
;;
