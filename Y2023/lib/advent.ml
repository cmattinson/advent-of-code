open Core

let read_lines file = In_channel.with_file file ~f:In_channel.input_lines
