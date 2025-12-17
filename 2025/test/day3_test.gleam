import days/day3

import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  util.read_lines("inputs/day3-example.txt")
  |> day3.solve
  |> should.equal(#(357, 3_121_910_778_619))
}
