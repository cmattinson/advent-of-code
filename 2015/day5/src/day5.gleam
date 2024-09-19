import gleam/int
import gleam/io
import gleam/list
import gleam/string
import part1
import part2
import simplifile

fn solve(content: String, solver: fn(String) -> Bool) -> Int {
  content
  |> string.split("\n")
  |> list.filter(fn(str) { !string.is_empty(str) })
  |> list.fold(0, fn(accum, str) {
    case solver(str) {
      True -> accum + 1
      False -> accum
    }
  })
}

pub fn main() {
  let assert Ok(content) = simplifile.read("day5.txt")

  let solution1 = solve(content, part1.is_nice_string)
  let solution2 = solve(content, part2.is_nice_string)

  io.println("Part 1 - " <> int.to_string(solution1))
  io.println("Part 2 - " <> int.to_string(solution2))
}
