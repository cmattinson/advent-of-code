open Util

let%expect_test _ =
  File.test_func |> Stdio.print_endline;
  [%expect]
