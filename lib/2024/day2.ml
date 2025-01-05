open Core

type accum =
  { safe : bool
  ; index : int
  }

let is_gradual num next = Int.between (Int.abs (num - next)) ~low:1 ~high:3
let is_ascending num next = next > num
let is_descending num next = next < num

let confirm nums ~f =
  List.for_alli nums ~f:(fun i num ->
    match List.nth nums (i + 1) with
    | Some next -> f num next
    | None -> true)
;;

let check nums =
  confirm nums ~f:is_gradual
  && (confirm nums ~f:is_descending || confirm nums ~f:is_ascending)
;;

let is_safe nums = check nums

let is_safe_dampened nums =
  if check nums
  then true
  else
    List.fold_until
      nums
      ~init:{ safe = false; index = 0 }
      ~f:(fun accum _num ->
        if is_safe (List.filteri nums ~f:(fun i _x -> i <> accum.index))
        then Stop true
        else Continue { safe = false; index = accum.index + 1 })
      ~finish:(fun result -> result.safe)
;;

let get_report line = line |> String.split ~on:' ' |> List.map ~f:Int.of_string

let solve input =
  let fold ~f =
    List.fold input ~init:0 ~f:(fun accum report ->
      if f (get_report report) then accum + 1 else accum)
  in
  Printf.printf "Part 1 - %d\n" (fold ~f:is_safe);
  Printf.printf "Part 2 - %d\n" (fold ~f:is_safe_dampened)
;;
