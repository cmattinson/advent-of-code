import days/day7

import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  util.read_file("inputs/day7-example.txt")
  |> day7.solve
  |> should.equal(#(21, 40))
}
