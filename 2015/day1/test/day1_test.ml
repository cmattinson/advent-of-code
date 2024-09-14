open Day1
open Util

let%expect_test "get_floor" =
  get_floor "(())" |> Display.print_int;
  [%expect {| 0 |}];
  get_floor "()()" |> Display.print_int;
  [%expect {| 0 |}];
  get_floor "(((" |> Display.print_int;
  [%expect {| 3 |}];
  get_floor "(()(()(" |> Display.print_int;
  [%expect {| 3 |}];
  get_floor "))(((((" |> Display.print_int;
  [%expect {| 3 |}];
  get_floor "())" |> Display.print_int;
  [%expect {| -1 |}];
  get_floor "))(" |> Display.print_int;
  [%expect {| -1 |}];
  get_floor ")))" |> Display.print_int;
  [%expect {| -3 |}];
  get_floor ")())())" |> Display.print_int;
  [%expect {| -3 |}]
;;

let%expect_test "basement_instruction" =
  basement_instruction ")" |> Display.print_int;
  [%expect {| 1 |}];
  basement_instruction "()())" |> Display.print_int;
  [%expect {| 5 |}]
;;
