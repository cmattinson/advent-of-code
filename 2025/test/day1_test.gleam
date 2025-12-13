import days/day1
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  case util.read_lines("inputs/day1-example.txt") {
    Some(lines) -> should.equal(day1.solve(lines), #(3, 6))
    None -> should.be_true(False)
  }
}
