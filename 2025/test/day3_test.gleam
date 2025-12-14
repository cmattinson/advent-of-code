import days/day3
import gleam/list
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  case util.read_lines("inputs/day3-example.txt") {
    Some(input) -> {
      should.equal(day3.solve(input), #(357, 3_121_910_778_619))
    }
    None -> should.be_true(False)
  }
}
