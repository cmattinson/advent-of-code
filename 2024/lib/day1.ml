open Core

type collector =
  { a : int list
  ; b : int list
  }

let parse_input input =
  input
  |> List.fold ~init:{ a = []; b = [] } ~f:(fun accum line ->
    let split = String.split line ~on:' ' in
    match List.hd split, List.last split with
    | Some x, Some y -> { a = int_of_string x :: accum.a; b = int_of_string y :: accum.b }
    | _ -> failwith "Invalid line")
;;

let solve_part_1 input =
  let parsed = input |> parse_input in
  let a_sorted = List.sort parsed.a ~compare:Int.compare in
  let b_sorted = List.sort parsed.b ~compare:Int.compare in
  match
    List.fold2 a_sorted b_sorted ~init:0 ~f:(fun accum x y -> accum + Int.abs (x - y))
  with
  | Ok result -> result
  | _ -> failwith "Can not fold lists"
;;

let solve_part_2 input =
  let parsed = input |> parse_input in
  let occurence_map =
    List.fold
      parsed.b
      ~init:(Map.empty (module Int))
      ~f:(fun accum x ->
        match Map.find accum x with
        | Some value -> Map.set accum ~key:x ~data:(value + 1)
        | None -> Map.set accum ~key:x ~data:1)
  in
  List.fold parsed.a ~init:0 ~f:(fun accum x ->
    match Map.find occurence_map x with
    | Some value -> accum + (x * value)
    | None -> accum)
;;

let solve input =
  Printf.printf "Part 1 - %d\n" (solve_part_1 input);
  Printf.printf "Part 2 - %d\n" (solve_part_2 input)
;;
