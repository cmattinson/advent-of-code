import days/day8

import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  util.read_lines("inputs/day8-example.txt")
  |> day8.solve_example
  |> should.equal(#(0, 0))
}
