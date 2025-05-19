open Core

type rule =
  { before : int
  ; after : int
  }
[@@deriving show]

type update = int list [@@deriving show]
type update_list = update list [@@deriving show]

type collector =
  { rules : rule list
  ; updates : update_list
  }

type result =
  { rule : rule
  ; valid : bool
  }
[@@deriving show]

type result_list = result list [@@deriving show]

module IntTuple = struct
  type t = int * int [@@deriving compare, hash, sexp]
end

let parse_rule line =
  let int_array =
    String.split line ~on:'|' |> Array.of_list |> Array.map ~f:Int.of_string
  in
  { before = int_array.(0); after = int_array.(1) }
;;

let parse_update line =
  let values = String.split line ~on:',' in
  List.map values ~f:Int.of_string
;;

let create_map update =
  let map = Hashtbl.create (module Int) in
  List.iteri update ~f:(fun i value -> Hashtbl.set map ~key:value ~data:i);
  map
;;

let follows_rules rules update =
  let map = create_map update in
  List.for_all rules ~f:(fun rule ->
    match Hashtbl.find map rule.before, Hashtbl.find map rule.after with
    | None, _ | _, None -> true
    | Some before_idx, Some after_idx -> before_idx < after_idx)
;;

let sort_invalid_update rules update =
  let invalid_map = Hashtbl.create (module IntTuple) in
  let () =
    List.iter rules ~f:(fun rule ->
      Hashtbl.set invalid_map ~key:(rule.after, rule.before) ~data:true)
  in
  let sort_func a b =
    match Hashtbl.find invalid_map (a, b) with
    | None | Some false -> 0
    | Some true -> 1
  in
  let sorted = List.sort update ~compare:sort_func in
  List.nth_exn sorted (List.length sorted / 2)
;;

let part1 { rules; updates } =
  List.fold updates ~init:0 ~f:(fun accum update ->
    if follows_rules rules update
    then (
      let middle = List.nth_exn update (List.length update / 2) in
      accum + middle)
    else accum)
;;

let part2 { rules; updates } =
  let invalid_updates =
    List.fold updates ~init:[] ~f:(fun accum update ->
      if not (follows_rules rules update) then update :: accum else accum)
  in
  List.fold invalid_updates ~init:0 ~f:(fun accum update ->
    let sorted_middle = sort_invalid_update rules update in
    accum + sorted_middle)
;;

let solve input =
  let result =
    input
    |> List.fold ~init:{ rules = []; updates = [] } ~f:(fun accum line ->
      match line with
      | line when String.contains line '|' ->
        { accum with rules = parse_rule line :: accum.rules }
      | line when String.contains line ',' ->
        { accum with updates = parse_update line :: accum.updates }
      | _ -> accum)
  in
  Printf.printf "Part 1 - %d\n" (part1 result);
  Printf.printf "Part 2 - %d\n" (part2 result)
;;
