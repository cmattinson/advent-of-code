open Aoc
open Core

let%expect_test "sum_instructions" =
  Printf.printf
    "%d\n"
    (Day3.sum_instructions
       "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))");
  [%expect {| 161 |}]
;;

let%expect_test "sum_enabled_instructions" =
  Printf.printf
    "%d\n"
    (Day3.sum_enabled_instructions
       "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))");
  [%expect {| 48 |}]
;;
