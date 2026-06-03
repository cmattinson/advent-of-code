import days/day12

import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  util.read_lines("inputs/day12-example.txt")
  |> day12.solve
  |> should.equal(#(0, 0))
}
