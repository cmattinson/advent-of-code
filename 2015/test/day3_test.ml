open Core
open Util
open Day3_lib

let%expect_test "unique_houses" =
  ">" |> String.to_list |> unique_houses |> Display.print_int;
  [%expect {| 2 |}];
  "^>v<" |> String.to_list |> unique_houses |> Display.print_int;
  [%expect {| 4 |}];
  "^v^v^v^v^v" |> String.to_list |> unique_houses |> Display.print_int;
  [%expect {| 2 |}]
;;

let%expect_test "unique_houses_robo" =
  "^v" |> String.to_list |> unique_houses_robo |> Display.print_int;
  [%expect {| 3 |}];
  "^>v<" |> String.to_list |> unique_houses_robo |> Display.print_int;
  [%expect {| 3 |}];
  "^v^v^v^v^v" |> String.to_list |> unique_houses_robo |> Display.print_int;
  [%expect {| 11 |}]
;;
