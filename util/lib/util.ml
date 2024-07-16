open! Core

module Display = struct
  let string_option (opt : string option) =
    match opt with
    | Some str -> Printf.printf "Some %s\n" str
    | None -> Stdio.print_endline "None"
end
