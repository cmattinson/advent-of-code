open! Core

type char_list = char list [@@deriving show]

module TupleMap = Map.Make (struct
    type t = int * int [@@deriving sexp, compare]
  end)

let solve input =
  let m = TupleMap.(empty) in
  input
  |> List.map ~f:String.to_list
  |> List.mapi ~f:(fun row chars ->
    List.mapi chars ~f:(fun column letter -> Map.set m ~key:(row, column) ~data:letter))
;;
