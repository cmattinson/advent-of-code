import argv
import days/day1
import days/day2
import days/day3
import days/day4
import days/day5
import days/day6
import gleam/io
import gleam/option.{type Option, None, Some}
import gleam/string
import util

fn execute(solver: fn(t) -> #(Int, Int), on: Option(t)) {
  case on {
    Some(input) -> {
      let #(part1, part2) = solver(input)
      io.println("Part 1: " <> string.inspect(part1))
      io.println("Part 2: " <> string.inspect(part2))
    }
    None -> io.println("Could not read input")
  }
}

pub fn main() -> Nil {
  case argv.load().arguments {
    [] -> io.println("No arguments provided")
    ["1"] -> execute(day1.solve, util.read_lines("inputs/day1.txt"))
    ["2"] -> execute(day2.solve, util.read_file("inputs/day2.txt"))
    ["3"] -> execute(day3.solve, util.read_lines("inputs/day3.txt"))
    ["4"] -> execute(day4.solve, util.read_file("inputs/day4.txt"))
    ["5"] -> execute(day5.solve, util.read_file("inputs/day5.txt"))
    ["6"] -> execute(day6.solve, util.read_lines_untrimmed("inputs/day6.txt"))
    _ -> io.println("Not implemented")
  }
}
