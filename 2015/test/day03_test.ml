open Core
open Day03_lib

let%expect_test "unique_houses" =
  ">" |> String.to_list |> unique_houses |> Printf.printf "%d\n";
  [%expect {| 2 |}];
  "^>v<" |> String.to_list |> unique_houses |> Printf.printf "%d\n";
  [%expect {| 4 |}];
  "^v^v^v^v^v" |> String.to_list |> unique_houses |> Printf.printf "%d\n";
  [%expect {| 2 |}]
;;

let%expect_test "unique_houses_robo" =
  "^v" |> String.to_list |> unique_houses_robo |> Printf.printf "%d\n";
  [%expect {| 3 |}];
  "^>v<" |> String.to_list |> unique_houses_robo |> Printf.printf "%d\n";
  [%expect {| 3 |}];
  "^v^v^v^v^v" |> String.to_list |> unique_houses_robo |> Printf.printf "%d\n";
  [%expect {| 11 |}]
;;
