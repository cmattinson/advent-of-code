import days/day6
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  case util.read_lines("inputs/day6-example.txt") {
    Some(lines) -> should.equal(day6.solve(lines), #(4_277_556, 3_263_827))
    None -> should.be_true(False)
  }
}
