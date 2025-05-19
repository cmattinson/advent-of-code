open Aoc.Day7

type char_list = char list list [@@deriving show]

let show_permutations perms = Printf.printf "%s\n" (show_char_list perms)

let%expect_test _ =
  Equation.generate_permutations ~chars:[ '+'; '*' ] ~max_length:3 |> show_permutations;
  [%expect {|
    [['+'; '+'; '+']; ['+'; '+'; '+']; ['+'; '+'; '*']; ['+'; '+'; '*'];
      ['+'; '*'; '+']; ['+'; '*'; '+']; ['+'; '*'; '*']; ['+'; '*'; '*'];
      ['*'; '+'; '+']; ['*'; '+'; '+']; ['*'; '+'; '*']; ['*'; '+'; '*'];
      ['*'; '*'; '+']; ['*'; '*'; '+']; ['*'; '*'; '*']; ['*'; '*'; '*']]
    |}]
;;
