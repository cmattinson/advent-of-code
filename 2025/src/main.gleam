import argv
import days/day1
import days/day10
import days/day11
import days/day2
import days/day3
import days/day4
import days/day5
import days/day6
import days/day7
import days/day8
import days/day9
import gleam/io
import gleam/string
import util

fn execute(solver: fn(t) -> #(Int, Int), on: t) {
  let #(part1, part2) = solver(on)
  io.println("Part 1: " <> string.inspect(part1))
  io.println("Part 2: " <> string.inspect(part2))
}

pub fn main() -> Nil {
  case argv.load().arguments {
    [] -> io.println("usage: gleam run {1 - 12}")
    ["1"] -> execute(day1.solve, util.read_lines("inputs/day1.txt"))
    ["2"] -> execute(day2.solve, util.read_file("inputs/day2.txt"))
    ["3"] -> execute(day3.solve, util.read_lines("inputs/day3.txt"))
    ["4"] -> execute(day4.solve, util.read_file("inputs/day4.txt"))
    ["5"] -> execute(day5.solve, util.read_file("inputs/day5.txt"))
    ["6"] -> execute(day6.solve, util.read_lines_raw("inputs/day6.txt"))
    ["7"] -> execute(day7.solve, util.read_file("inputs/day7.txt"))
    ["8"] -> execute(day8.solve, util.read_lines("inputs/day8.txt"))
    ["9"] -> execute(day9.solve, util.read_lines("inputs/day9.txt"))
    ["10"] -> execute(day10.solve, util.read_lines("inputs/day10.txt"))
    ["11"] -> execute(day11.solve, util.read_lines("inputs/day11.txt"))
    _ -> io.println("Not implemented")
  }
}
