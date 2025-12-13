import days/day2
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  case util.read_file("inputs/day2-example.txt") {
    Some(input) -> {
      should.equal(day2.solve(input), #(1_227_775_554, 4_174_379_265))
    }
    None -> should.be_true(False)
  }
}

pub fn sequence_repeats_test() {
  should.equal(day2.sequence_repeats([1, 1]), True)
  should.equal(day2.sequence_repeats([2, 2]), True)
  should.equal(day2.sequence_repeats([1, 3]), False)
}

pub fn sequence_repeats_at_least_twice_test() {
  should.equal(day2.sequence_repeats_at_least_twice([1, 1]), True)
  should.equal(day2.sequence_repeats_at_least_twice([2, 2]), True)
  should.equal(day2.sequence_repeats_at_least_twice([9, 9]), True)
  should.equal(day2.sequence_repeats_at_least_twice([1, 1, 1]), True)
  should.equal(day2.sequence_repeats_at_least_twice([4, 4, 6, 4, 4, 6]), True)
}
