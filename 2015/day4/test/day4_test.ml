open Day4
open Util

let%expect_test "hash_string" =
  hash_string "abcdef609043" |> Stdio.print_endline;
  [%expect {| 000001dbbfa3a5c83a2d506429c7b00e |}]
;;

let%expect_test "find_lowest_num" =
  find_lowest_num "abcdef" ~pattern:"00000" |> Display.print_int;
  [%expect {| 609043 |}];
  find_lowest_num "pqrstuv" ~pattern:"00000" |> Display.print_int;
  [%expect {| 1048970 |}];
  find_lowest_num "yzbqklnj" ~pattern:"00000" |> Display.print_int;
  [%expect {| 282749 |}]
;;
