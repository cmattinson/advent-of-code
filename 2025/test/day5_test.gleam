import days/day5
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  case util.read_file("inputs/day5-example.txt") {
    Some(input) -> {
      should.equal(day5.solve(input), #(3, 14))
    }
    None -> should.be_true(False)
  }
}
