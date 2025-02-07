open! Core
open Re.Pcre

type accum =
  { sum : int
  ; enabled : bool
  }

let process_sum str =
  match String.split_on_chars str ~on:[ '('; ','; ')' ] with
  | _ :: x :: y :: _ -> Int.of_string x * Int.of_string y
  | _ -> 0
;;

let sum_instructions str =
  let pattern = {|mul(\([0-9]{1,3},[0-9]{1,3}\))|} in
  full_split ~rex:(regexp pattern) str
  |> List.map ~f:(function
    | Group (_nr, str) -> process_sum str
    | _ -> 0)
  |> List.fold ~init:0 ~f:( + )
;;

let sum_enabled_instructions str =
  let pattern = {|mul(\([0-9]{1,3},[0-9]{1,3}\))|(do)\(\)|(don't)\(\)|} in
  let result =
    full_split ~rex:(regexp pattern) str
    |> List.fold ~init:{ sum = 0; enabled = true } ~f:(fun accum g ->
      match g with
      | Group (nr, str) ->
        (match nr with
         | 1 when accum.enabled -> { accum with sum = accum.sum + process_sum str }
         | 2 -> { accum with enabled = true }
         | 3 -> { accum with enabled = false }
         | _ -> accum)
      | _ -> accum)
  in
  result.sum
;;

let solve input =
  Printf.printf "Part 1 - %d\n" (sum_instructions input);
  Printf.printf "Part 2 - %d\n" (sum_enabled_instructions input)
;;
