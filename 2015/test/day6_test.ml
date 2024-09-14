open Day6_lib
open Core

let%expect_test "of_string" =
  "turn on 489,959 through 759,964" |> Instruction.of_string |> Instruction.print;
  [%expect {| { action = On; top_left = (489, 959); bottom_right = (759, 964) } |}];
  "turn off 820,516 through 871,914" |> Instruction.of_string |> Instruction.print;
  [%expect {| { action = Off; top_left = (820, 516); bottom_right = (871, 914) } |}];
  "toggle 756,965 through 812,992" |> Instruction.of_string |> Instruction.print;
  [%expect {| { action = Toggle; top_left = (756, 965); bottom_right = (812, 992) } |}]
;;
