open Day02_lib

let%expect_test "smallest_area" =
  smallest_area 2 3 4 |> Printf.printf "%d\n";
  [%expect {| 6 |}]
;;

let%expect_test "required_area" =
  let box = create_box 2 3 4 in
  box |> required_area |> Printf.printf "%d\n";
  [%expect {| 58 |}];
  let box2 = create_box 1 1 10 in
  box2 |> required_area |> Printf.printf "%d\n";
  [%expect {| 43 |}]
;;

let%expect_test "ribbon_amout" =
  let box = create_box 2 3 4 in
  box |> ribbon_amount |> Printf.printf "%d\n";
  [%expect {| 34 |}];
  let box2 = create_box 1 1 10 in
  box2 |> ribbon_amount |> Printf.printf "%d\n";
  [%expect {| 14 |}]
;;
