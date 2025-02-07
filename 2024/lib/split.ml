open Core

module Acronym = struct
  let abbreviate str =
    str
    |> String.filter ~f:(fun char ->
      Char.is_alpha char || Char.equal char '-' || Char.equal char ' ')
    |> String.split_on_chars ~on:[ ' '; '-' ]
    |> List.map ~f:(fun str -> Char.uppercase str.[0])
    |> List.fold ~init:"" ~f:(fun accum char -> String.append accum (Char.to_string char))
    |> Stdio.print_endline
  ;;
end
