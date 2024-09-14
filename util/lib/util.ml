open! Core

module Display = struct
  let string_option (opt : string option) =
    match opt with
    | Some str -> Printf.printf "Some %s\n" str
    | None -> Stdio.print_endline "None"
  ;;

  let print_int n = Printf.printf "%d\n" n

  let print_bool = function
    | true -> Stdio.print_endline "true"
    | false -> Stdio.print_endline "false"
  ;;
end

module Iter = struct
  let iter_window2 (list : 'a list) ~f =
    let rec aux list =
      match list with
      | [] -> ()
      | _ :: [] -> ()
      | first :: next :: rest ->
        f first next;
        aux rest
    in
    aux list
  ;;
end
