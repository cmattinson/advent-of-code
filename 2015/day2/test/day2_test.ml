open Day2
open Util

let%expect_test "smallest_area" =
  smallest_area 2 3 4 |> Display.print_int;
  [%expect {| 6 |}]
;;

let%expect_test "required_area" =
  let box = create_box 2 3 4 in
  box |> required_area |> Display.print_int;
  [%expect {| 58 |}];
  let box2 = create_box 1 1 10 in
  box2 |> required_area |> Display.print_int;
  [%expect {| 43 |}]
;;

let%expect_test "ribbon_amout" =
  let box = create_box 2 3 4 in
  box |> ribbon_amount |> Display.print_int;
  [%expect {| 34 |}];
  let box2 = create_box 1 1 10 in
  box2 |> ribbon_amount |> Display.print_int;
  [%expect {| 14 |}]
;;
