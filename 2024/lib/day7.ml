open Core

module Equation = struct
  type t =
    { target : int
    ; values : int list
    }
  [@@deriving show]

  let parse line =
    let split = String.split line ~on:':' in
    match split with
    | target :: [ rest ] ->
      { target = int_of_string target
      ; values = rest |> String.strip |> String.split ~on:' ' |> List.map ~f:int_of_string
      }
    | _ -> failwith "Invalid line"
  ;;

  let generate_permutations ~(chars : char list) ~max_length =
    let rec helper acc length =
      if length = 0
      then acc
      else (
        let new_acc =
          List.concat (List.map chars ~f:(fun c1 -> List.map acc ~f:(fun c2 -> c1 :: c2)))
        in
        helper new_acc (length - 1))
    in
    helper [ []; [] ] max_length
  ;;
end

let solve input =
  input
  |> List.map ~f:Equation.parse
  |> List.iter ~f:(fun lst -> Printf.printf "%s\n" (Equation.show lst))
;;
