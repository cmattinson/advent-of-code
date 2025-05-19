open! Core

type char_array_array = char array array [@@deriving show]

let solve input =
  let array =
    input
    |> String.split_lines
    |> List.to_array
    |> Array.map ~f:(fun line -> String.to_array line)
  in
  Stdio.print_endline (show_char_array_array array)
;;

let split_items = String.split_on_chars ~on:[ '|' ]
