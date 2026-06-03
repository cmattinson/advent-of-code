open Core

let read_input input = In_channel.read_all input
let read_lines input = In_channel.with_file input ~f:In_channel.input_lines
