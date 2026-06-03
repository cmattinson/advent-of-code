open! Core

type block =
  { id : int option
  ; size : int
  }

let parse_blocks input =
  let chars = String.to_array (String.strip input) in
  let _, rev_blocks =
    Array.foldi chars ~init:(0, []) ~f:(fun i (id, acc) c ->
      let n = Char.get_digit_exn c in
      if n = 0
      then if i % 2 = 0 then id, acc else id + 1, acc
      else if i % 2 = 0
      then id, { id = Some id; size = n } :: acc
      else id + 1, { id = None; size = n } :: acc)
  in
  List.rev rev_blocks
;;

let flatten blocks =
  let total = List.fold blocks ~init:0 ~f:(fun acc b -> acc + b.size) in
  let arr = Array.create ~len:total None in
  let pos = ref 0 in
  List.iter blocks ~f:(fun { id; size } ->
    match id with
    | Some file_id ->
      for _ = 1 to size do
        arr.(!pos) <- Some file_id;
        incr pos
      done
    | None -> pos := !pos + size);
  arr
;;

let compact_blocks blocks =
  let right = ref (Array.length blocks - 1) in
  Array.iteri blocks ~f:(fun index block ->
    if !right > index
    then (
      match block with
      | None ->
        while !right > index && Option.is_none blocks.(!right) do
          decr right
        done;
        if !right > index
        then (
          Array.swap blocks index !right;
          decr right)
      | Some _ -> ()));
  blocks
;;

let compact_whole_files blocks =
  let flat = flatten blocks in
  let _, file_info =
    List.fold blocks ~init:(0, []) ~f:(fun (pos, acc) { id; size } ->
      ( pos + size
      , match id with
        | Some file_id -> (file_id, pos, size) :: acc
        | None -> acc ))
  in
  let find_fit file_start file_size =
    let rec scan i =
      if i >= file_start
      then None
      else if Option.is_none flat.(i)
      then (
        let run_start = i in
        let rec count j =
          if j >= file_start || Option.is_some flat.(j) then j else count (j + 1)
        in
        let run_end = count (i + 1) in
        if run_end - run_start >= file_size then Some run_start else scan run_end)
      else scan (i + 1)
    in
    scan 0
  in
  List.iter file_info ~f:(fun (file_id, file_start, file_size) ->
    match find_fit file_start file_size with
    | None -> ()
    | Some start ->
      for k = 0 to file_size - 1 do
        flat.(start + k) <- Some file_id;
        flat.(file_start + k) <- None
      done);
  flat
;;

let calculate_checksum blocks =
  Array.foldi blocks ~init:0 ~f:(fun index acc block ->
    match block with
    | None -> acc
    | Some id -> acc + (id * index))
;;

let solve_part_1 input =
  input |> parse_blocks |> flatten |> compact_blocks |> calculate_checksum
;;

let solve_part_2 input =
  input |> parse_blocks |> compact_whole_files |> calculate_checksum
;;

let solve input =
  Printf.printf "Part 1 - %d\nPart 2 - %d\n" (solve_part_1 input) (solve_part_2 input)
;;
