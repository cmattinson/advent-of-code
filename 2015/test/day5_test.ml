open Day5_lib
open Util
open Core

let%expect_test "vowel_count" =
  "aei" |> P1.vowel_count |> Display.print_int;
  [%expect {| 3 |}];
  "xazegov" |> P1.vowel_count |> Display.print_int;
  [%expect {| 3 |}];
  "aeiouaeiouaeiou" |> P1.vowel_count |> Display.print_int;
  [%expect {| 15 |}]
;;

let%expect_test "has_consecutive_letter" =
  "xx" |> P1.has_consecutive_letter |> Display.print_bool;
  [%expect {| true |}];
  "abcdde" |> P1.has_consecutive_letter |> Display.print_bool;
  [%expect {| true |}];
  "aabbccdd" |> P1.has_consecutive_letter |> Display.print_bool;
  [%expect {| true |}];
  "doesnothaveconsecutive" |> P1.has_consecutive_letter |> Display.print_bool;
  [%expect {| false |}]
;;

let%expect_test "has_invalid_substring" =
  "about" |> P1.has_invalid_substring |> Display.print_bool;
  [%expect {| true |}];
  "cdoe" |> P1.has_invalid_substring |> Display.print_bool;
  [%expect {| true |}];
  "pqsl" |> P1.has_invalid_substring |> Display.print_bool;
  [%expect {| true |}];
  "faxy" |> P1.has_invalid_substring |> Display.print_bool;
  [%expect {| true |}];
  "doesnothaveinvalidsubstring" |> P1.has_invalid_substring |> Display.print_bool;
  [%expect {| false |}]
;;

let%expect_test "is_nice_string P1" =
  "ugknbfddgicrmopn" |> P1.is_nice_string |> Display.print_bool;
  [%expect {| true |}];
  "aaa" |> P1.is_nice_string |> Display.print_bool;
  [%expect {| true |}];
  "jchzalrnumimnmhp" |> P1.is_nice_string |> Display.print_bool;
  [%expect {| false |}];
  "haegwjzuvuyypxyu" |> P1.is_nice_string |> Display.print_bool;
  [%expect {| false |}];
  "dvszwmarrgswjxmb" |> P1.is_nice_string |> Display.print_bool;
  [%expect {| false |}]
;;

let%expect_test "letter_pairs" =
  "aabbcc" |> P2.letter_pairs |> List.length |> Display.print_int;
  [%expect {| 3 |}];
  "aaa" |> P2.letter_pairs |> List.length |> Display.print_int;
  [%expect {| 1 |}];
  "xyxy" |> P2.letter_pairs |> List.length |> Display.print_int;
  [%expect {| 2 |}]
;;

let%expect_test "has_letter_sandwich" =
  "xyx" |> P2.has_letter_sandwich |> Display.print_bool;
  [%expect {| true |}];
  "aaa" |> P2.has_letter_sandwich |> Display.print_bool;
  [%expect {| true |}];
  "abc" |> P2.has_letter_sandwich |> Display.print_bool;
  [%expect {| false |}]
;;

let%expect_test "is_nice_string P2" =
  "qjhvhtzxzqqjkmpb" |> P2.is_nice_string |> Display.print_bool;
  [%expect {||}];
  "xxyxx" |> P2.is_nice_string |> Display.print_bool;
  [%expect {||}];
  "uurcxstgmygtbstg" |> P2.is_nice_string |> Display.print_bool;
  [%expect {||}];
  "ieodomkazucvgmuy" |> P2.is_nice_string |> Display.print_bool;
  [%expect {||}]
;;
