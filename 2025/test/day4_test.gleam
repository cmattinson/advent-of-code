import days/day4

import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  util.read_file("inputs/day4-example.txt")
  |> day4.solve
  |> should.equal(#(13, 43))
}
