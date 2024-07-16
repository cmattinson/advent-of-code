open Core

exception BasementFloor of int

let get_floor str =
  str
  |> String.to_list
  |> List.fold ~init:0 ~f:(fun accum char ->
    match char with
    | '(' -> accum + 1
    | ')' -> accum - 1
    | _ -> accum + 0)
;;

let basement_instruction str : int =
  try
    str
    |> String.to_list
    |> List.foldi ~init:0 ~f:(fun index accum char ->
      let next_accum =
        match char with
        | '(' -> accum + 1
        | ')' -> accum - 1
        | _ -> accum
      in
      if next_accum = -1 then raise (BasementFloor (index + 1)) else next_accum)
  with
  | BasementFloor index -> index
;;
