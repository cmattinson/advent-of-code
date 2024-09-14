open! Core

module P1 = struct
  exception FoundConsecutive of bool

  let vowel_count str =
    str
    |> String.to_list
    |> List.fold ~init:0 ~f:(fun accum char ->
      match char with
      | 'a' | 'e' | 'i' | 'o' | 'u' -> accum + 1
      | _ -> accum)
  ;;

  let has_consecutive_letter str =
    let rec iter list =
      try
        match list with
        | [] -> false
        | _ :: [] -> false
        | char :: rest when Char.equal char (List.hd_exn rest) ->
          raise (FoundConsecutive true)
        | _ :: rest -> iter rest
      with
      | FoundConsecutive value -> value
    in
    iter (String.to_list str)
  ;;

  let has_invalid_substring str =
    String.is_substring str ~substring:"ab"
    || String.is_substring str ~substring:"cd"
    || String.is_substring str ~substring:"pq"
    || String.is_substring str ~substring:"xy"
  ;;

  let is_nice_string str =
    vowel_count str >= 3 && has_consecutive_letter str && not (has_invalid_substring str)
  ;;
end

module P2 = struct
  exception FoundSandwich of bool

  type pair_accum =
    { pairs : string list
    ; candidate : string
    }

  let accum_init = { pairs = []; candidate = "" }

  let letter_pairs str =
    let result =
      str
      |> String.to_list
      |> List.fold ~init:accum_init ~f:(fun accum char ->
        if String.length accum.candidate = 1
        then (
          let new_pair = accum.candidate ^ String.of_char char in
          { pairs = new_pair :: accum.pairs; candidate = "" })
        else { pairs = accum.pairs; candidate = accum.candidate ^ String.of_char char })
    in
    result.pairs
  ;;

  let has_duplicate_pairs list = list |> List.contains_dup ~compare:String.compare

  let has_letter_sandwich str =
    let rec iter list =
      try
        match list with
        | hd :: _ :: rest when Char.equal hd (List.hd_exn rest) ->
          raise (FoundSandwich true)
        | _ :: rest -> iter rest
        | [] -> raise (FoundSandwich false)
      with
      | FoundSandwich v -> v
    in
    str |> String.to_list |> iter
  ;;

  let is_nice_string str =
    letter_pairs str |> has_duplicate_pairs && has_letter_sandwich str
  ;;
end
