import days/day5

import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  util.read_file("inputs/day5-example.txt")
  |> day5.solve
  |> should.equal(#(3, 14))
}
