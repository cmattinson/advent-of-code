open! Core
open! Cryptokit

let hash_string str =
  let hash = Hash.md5 () in
  hash#add_string str;
  hash#result |> transform_string (Hexa.encode ())
;;

let find_lowest_num key ~pattern =
  let exit = ref false in
  let index = ref 0 in
  while not !exit do
    let combined = key ^ Int.to_string !index in
    let hash = hash_string combined in
    let starts_with_pattern =
      match String.substr_index hash ~pattern with
      | Some index when index = 0 -> true
      | _ -> false
    in
    if starts_with_pattern then exit := true else index := !index + 1
  done;
  !index
;;
