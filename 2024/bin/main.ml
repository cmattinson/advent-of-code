open Core
open Aoc

let read_file file = In_channel.read_all file
let read_lines file = In_channel.with_file file ~f:In_channel.input_lines

let command =
  Command.basic
    ~summary:"Advent of Code solutions"
    (let%map_open.Command day = flag "-d" (required string) ~doc:"day day for solution"
     and input_file =
       flag "-i" (optional string) ~doc:"file file used as input, relative to inputs/"
     in
     fun () ->
       let input =
         match input_file with
         | Some file -> "inputs/" ^ file
         | None -> "inputs/day" ^ day ^ ".txt"
       in
       match day with
       | "1" -> Day1.solve (read_lines input)
       | "2" -> Day2.solve (read_lines input)
       | "3" -> Day3.solve (read_file input)
       | "4" -> Day4.solve (read_file input)
       | "5" -> Day5.solve (read_lines input)
       | "6" -> Day6.solve (read_lines input)
       | "7" -> Day7.solve (read_lines input)
       | "8" -> Day8.solve (read_file input)
       | _ -> Stdio.print_endline "Day not solved")
;;

let () = Command_unix.run command
