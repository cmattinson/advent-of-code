open Aoc

let print_bool = function
  | true -> Stdio.print_endline "true"
  | false -> Stdio.print_endline "false"
;;

let%expect_test "2024 Day 2 - part 1" =
  print_bool (Day2.is_safe [ 7; 6; 4; 2; 1 ]);
  [%expect {| true |}];
  print_bool (Day2.is_safe [ 1; 2; 7; 8; 9 ]);
  [%expect {| false |}];
  print_bool (Day2.is_safe [ 9; 7; 6; 2; 1 ]);
  [%expect {| false |}];
  print_bool (Day2.is_safe [ 1; 3; 2; 4; 5 ]);
  [%expect {| false |}];
  print_bool (Day2.is_safe [ 8; 6; 4; 4; 1 ]);
  [%expect {| false |}];
  print_bool (Day2.is_safe [ 1; 3; 6; 7; 9 ]);
  [%expect {| true |}]
;;

let%expect_test "2024 Day 2 - part 2" =
  print_bool (Day2.is_safe_dampened [ 7; 6; 4; 2; 1 ]);
  [%expect {| true |}];
  print_bool (Day2.is_safe_dampened [ 1; 2; 7; 8; 9 ]);
  [%expect {| false |}];
  print_bool (Day2.is_safe_dampened [ 9; 7; 6; 2; 1 ]);
  [%expect {| false |}];
  print_bool (Day2.is_safe_dampened [ 1; 3; 2; 4; 5 ]);
  [%expect {| true |}];
  print_bool (Day2.is_safe_dampened [ 8; 6; 4; 4; 1 ]);
  [%expect {| true |}];
  print_bool (Day2.is_safe_dampened [ 1; 3; 6; 7; 9 ]);
  [%expect {| true |}]
;;
