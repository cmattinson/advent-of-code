open! Core

module Coordinate = struct
  type t = int * int

  let compare (x1, y1) (x2, y2) =
    let comp1 = compare x1 x2 in
    if comp1 = 0 then compare y1 y2 else comp1
  ;;
end

module CoordinateSet = Stdlib.Set.Make (Coordinate)

let unique_coordinate_count coordinates =
  coordinates |> CoordinateSet.of_list |> CoordinateSet.to_list |> List.length
;;

let unique_houses list =
  let coordinate_list =
    List.fold
      list
      ~init:[ 0, 0 ]
      ~f:(fun accum char ->
        let current = List.hd_exn accum in
        match char with
        | '>' -> (fst current + 1, snd current) :: accum
        | 'v' -> (fst current, snd current - 1) :: accum
        | '<' -> (fst current - 1, snd current) :: accum
        | '^' -> (fst current, snd current + 1) :: accum
        | _ -> accum)
  in
  coordinate_list |> unique_coordinate_count
;;

let unique_houses_robo list =
  let coordinate_lists =
    List.foldi
      list
      ~init:[| [ 0, 0 ]; [ 0, 0 ] |]
      ~f:(fun index accum char ->
        (* Santa or Robo *)
        let worker_index = if index mod 2 = 0 then 0 else 1 in
        let current = List.hd_exn (Array.get accum worker_index) in
        match char with
        | '>' ->
          Array.set
            accum
            worker_index
            ((fst current + 1, snd current) :: Array.get accum worker_index);
          accum
        | 'v' ->
          Array.set
            accum
            worker_index
            ((fst current, snd current - 1) :: Array.get accum worker_index);
          accum
        | '<' ->
          Array.set
            accum
            worker_index
            ((fst current - 1, snd current) :: Array.get accum worker_index);
          accum
        | '^' ->
          Array.set
            accum
            worker_index
            ((fst current, snd current + 1) :: Array.get accum worker_index);
          accum
        | _ -> accum)
  in
  List.append (Array.get coordinate_lists 0) (Array.get coordinate_lists 1)
  |> unique_coordinate_count
;;
