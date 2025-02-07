open Core

type result =
  { rules : string list
  ; pages : string list
  }

type string_list = string list [@@deriving show]

let solve input =
  let result =
    input
    |> List.fold ~init:{ rules = []; pages = [] } ~f:(fun accum line ->
      match line with
      | line when String.contains line '|' -> { accum with rules = line :: accum.rules }
      | line when String.contains line ',' -> { accum with pages = line :: accum.pages }
      | _ -> accum)
  in
  Printf.printf "%s\n\n%s" (show_string_list result.rules) (show_string_list result.pages)
;;
