open Aoc
open Core

let%expect_test "parse_rule" =
  let rule = Day5.parse_rule "43|12" in
  Printf.printf "%s\n" (Day5.show_rule rule);
  [%expect {| { Day5.before = 43; after = 12 } |}]
;;

let%expect_test "parse_update" =
  let update = Day5.parse_update "32,23,22" in
  Printf.printf "%s\n" (Day5.show_update update);
  [%expect {| [32; 23; 22] |}]
;;

let%expect_test "create_map" =
  let update = Day5.parse_update "32,23,22" in
  let map = Day5.create_map update in
  Hashtbl.iter map ~f:(fun key value -> Printf.printf "%d -> %d\n" key value);
  [%expect {| |}]
;;
