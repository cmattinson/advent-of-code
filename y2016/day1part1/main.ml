open Base

module Coordinate = struct
  type facing =
    | North
    | South
    | East
    | West

  type t =
    { mutable facing : facing
    ; mutable x : int
    ; mutable y : int
    }

  let init = { facing = North; x = 0; y = 0 }
end

module Direction = struct
  exception Invalid

  type t =
    { bearing : char
    ; blocks : int
    }

  let of_string s =
    let direction = String.get s 0 in
    let num = Int.of_string (Stdlib.String.sub s 1 (String.length s - 1)) in
    { bearing = direction; blocks = num }
  ;;

  let walk (direction : t) (coordinates : Coordinate.t) =
    match coordinates.facing, direction.bearing with
    | North, 'L' ->
      coordinates.facing <- West;
      coordinates.x <- coordinates.x - direction.blocks
    | North, 'R' ->
      coordinates.facing <- East;
      coordinates.x <- coordinates.x + direction.blocks
    | East, 'L' ->
      coordinates.facing <- North;
      coordinates.y <- coordinates.y + direction.blocks
    | East, 'R' ->
      coordinates.facing <- South;
      coordinates.y <- coordinates.y - direction.blocks
    | South, 'L' ->
      coordinates.facing <- East;
      coordinates.x <- coordinates.x + direction.blocks
    | South, 'R' ->
      coordinates.facing <- West;
      coordinates.x <- coordinates.x - direction.blocks
    | West, 'L' ->
      coordinates.facing <- South;
      coordinates.y <- coordinates.y - direction.blocks
    | West, 'R' ->
      coordinates.facing <- North;
      coordinates.y <- coordinates.y + direction.blocks
    | _ -> raise Invalid
  ;;
end

let solve input =
  input
  |> String.split ~on:','
  |> List.map ~f:(fun string -> String.strip string)
  |> List.fold ~init:Coordinate.init ~f:(fun accum string ->
    let direction = Direction.of_string string in
    let () = Direction.walk direction accum in
    accum)
;;

let () =
  let solution = Advent.read_file "input.txt" |> solve in
  Stdio.printf "%d\n" (abs solution.x + abs solution.y)
;;
