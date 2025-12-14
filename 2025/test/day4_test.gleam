import days/day4
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  case util.read_file("inputs/day4-example.txt") {
    Some(input) -> {
      should.equal(day4.solve(input), #(13, 43))
    }
    None -> should.be_true(False)
  }
}
