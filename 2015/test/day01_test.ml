open Day01_lib

let%expect_test "get_floor" =
  get_floor "(())" |> Printf.printf "%d\n";
  [%expect {| 0 |}];
  get_floor "()()" |> Printf.printf "%d\n";
  [%expect {| 0 |}];
  get_floor "(((" |> Printf.printf "%d\n";
  [%expect {| 3 |}];
  get_floor "(()(()(" |> Printf.printf "%d\n";
  [%expect {| 3 |}];
  get_floor "))(((((" |> Printf.printf "%d\n";
  [%expect {| 3 |}];
  get_floor "())" |> Printf.printf "%d\n";
  [%expect {| -1 |}];
  get_floor "))(" |> Printf.printf "%d\n";
  [%expect {| -1 |}];
  get_floor ")))" |> Printf.printf "%d\n";
  [%expect {| -3 |}];
  get_floor ")())())" |> Printf.printf "%d\n";
  [%expect {| -3 |}]
;;

let%expect_test "basement_instruction" =
  basement_instruction ")" |> Printf.printf "%d\n";
  [%expect];
  basement_instruction "()())" |> Printf.printf "%d\n";
  [%expect]
;;
