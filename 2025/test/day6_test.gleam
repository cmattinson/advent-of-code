import birdie
import days/day6

import gleam/string
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn parse_input_horizontal_test() {
  util.read_lines_raw("inputs/day6-example.txt")
  |> day6.parse_input_horizontal
  |> string.inspect
  |> birdie.snap(title: "parse_input_horizontal")
}

pub fn parse_input_vertical_test() {
  util.read_lines_raw("inputs/day6-example.txt")
  |> day6.parse_input_vertical
  |> string.inspect
  |> birdie.snap(title: "parse_input_vertical")
}

pub fn solve_test() {
  util.read_lines_raw("inputs/day6-example.txt")
  |> day6.solve
  |> should.equal(#(4_277_556, 3_263_827))
}
