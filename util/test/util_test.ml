open! Core
open! Util

let%expect_test "iter_window2" =
  "123456789"
  |> String.to_list
  |> Iter.iter_window2 ~f:(fun x y -> Printf.printf "%c%c " x y);
  [%expect]
;;
