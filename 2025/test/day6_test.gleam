import birdie
import days/day6
import gleam/option.{None, Some}
import gleam/string
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn parse_input_horizontal_test() {
  case util.read_lines_untrimmed("inputs/day6-example.txt") {
    Some(lines) -> {
      lines
      |> day6.parse_input_horizontal
      |> string.inspect
      |> birdie.snap(title: "parse_input_horizontal")
    }
    None -> should.be_true(False)
  }
}

pub fn parse_input_vertical_test() {
  case util.read_lines_untrimmed("inputs/day6-example.txt") {
    Some(lines) -> {
      lines
      |> day6.parse_input_vertical
      |> string.inspect
      |> birdie.snap(title: "parse_input_vertical")
    }
    None -> should.be_true(False)
  }
}

pub fn solve_test() {
  case util.read_lines_untrimmed("inputs/day6-example.txt") {
    Some(lines) -> should.equal(day6.solve(lines), #(4_277_556, 3_263_827))
    None -> should.be_true(False)
  }
}
