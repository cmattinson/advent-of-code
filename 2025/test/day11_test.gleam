import days/day11

import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn solve_test() {
  let val =
    util.read_lines("inputs/day11-example.txt")
    |> day11.solve

  val.0 |> should.equal(5)
}

pub fn example2_test() {
  let val =
    util.read_lines("inputs/day11-example2.txt")
    |> day11.solve

  val.1 |> should.equal(2)
}

pub fn debug_part2_test() {
  let input = [
    "svr: aaa bbb",
    "aaa: fft",
    "fft: ccc",
    "bbb: tty",
    "tty: ccc",
    "ccc: ddd eee",
    "ddd: hub",
    "hub: fff",
    "eee: dac",
    "dac: fff",
    "fff: ggg hhh",
    "ggg: out",
    "hhh: out",
  ]

  let val = day11.solve(input)
  val.1 |> should.equal(2)
}

pub fn test_simple_path() {
  let input = ["svr: dac", "dac: fft", "fft: out"]

  let val = day11.solve(input)
  val.1 |> should.equal(1)
}

pub fn test_branching_path() {
  let input = ["svr: fft", "fft: out1 out2", "out1: out", "out2: out"]

  let val = day11.solve(input)
  val.1 |> should.equal(0)
}

pub fn test_branching_with_dac() {
  let input = [
    "svr: fft dac",
    "fft: out1 out2",
    "dac: out1 out2",
    "out1: out",
    "out2: out",
  ]

  let val = day11.solve(input)
  val.1 |> should.equal(2)
}
