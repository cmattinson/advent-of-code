open! Core

module Instruction = struct
  type t =
    { action : [ `On | `Off | `Toggle ]
    ; top_left : int * int
    ; bottom_right : int * int
    }

  let init = { action = `Off; top_left = 0, 0; bottom_right = 999, 999 }

  let parse_pair pair =
    let split = pair |> String.split_on_chars ~on:[ ',' ] in
    match split with
    | [ hd; tl ] -> Int.of_string hd, Int.of_string tl
    | _ -> failwith "Invalid coordinate"
  ;;

  let of_string str =
    let remove = [ "turn"; "through" ] in
    let instructions =
      str
      |> String.split_on_chars ~on:[ ' ' ]
      |> List.filter ~f:(fun str -> not (List.mem remove str ~equal:String.equal))
    in
    match List.nth_exn instructions 0 with
    | "on" ->
      { action = `On
      ; top_left = parse_pair (List.nth_exn instructions 1)
      ; bottom_right = parse_pair (List.nth_exn instructions 2)
      }
    | "off" ->
      { action = `Off
      ; top_left = parse_pair (List.nth_exn instructions 1)
      ; bottom_right = parse_pair (List.nth_exn instructions 2)
      }
    | "toggle" ->
      { action = `Toggle
      ; top_left = parse_pair (List.nth_exn instructions 1)
      ; bottom_right = parse_pair (List.nth_exn instructions 2)
      }
    | _ -> failwith "Invalid instruction"
  ;;

  let print record =
    Printf.printf
      "{ action = %s; top_left = (%d, %d); bottom_right = (%d, %d) }\n"
      (match record.action with
       | `On -> "On"
       | `Off -> "Off"
       | `Toggle -> "Toggle")
      (fst record.top_left)
      (snd record.top_left)
      (fst record.bottom_right)
      (snd record.bottom_right)
  ;;
end

let act_on_lights grid (instruction : Instruction.t) =
  for x = fst instruction.top_left to fst instruction.bottom_right do
    for y = snd instruction.top_left to snd instruction.bottom_right do
      match instruction.action with
      | `On -> grid.(x).(y) <- true
      | `Off -> grid.(x).(y) <- false
      | `Toggle -> grid.(x).(y) <- not grid.(x).(y)
    done
  done
;;

let count_lights grid =
  let count = ref 0 in
  for x = 0 to 999 do
    for y = 0 to 999 do
      match grid.(x).(y) with
      | true -> count := !count + 1
      | _ -> ()
    done
  done;
  count
;;
