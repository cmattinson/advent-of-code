import gleam/dict
import gleam/list
import gleam/result
import gleam/string

type Accum {
  Accum(beams: dict.Dict(Int, Int), index: Int, splits: Int)
}

fn split_beams(acc: Accum, timesplit: Bool) -> Accum {
  case dict.get(acc.beams, acc.index) {
    Ok(count) -> {
      let left_count = case timesplit {
        True -> result.unwrap(dict.get(acc.beams, acc.index - 1), 0) + count
        False -> 1
      }
      let right_count = case timesplit {
        True -> result.unwrap(dict.get(acc.beams, acc.index + 1), 0) + count
        False -> 1
      }
      let splits_added = case timesplit {
        True -> count
        False -> 1
      }

      Accum(
        acc.beams
          |> dict.delete(acc.index)
          |> dict.insert(acc.index - 1, left_count)
          |> dict.insert(acc.index + 1, right_count),
        acc.index + 1,
        acc.splits + splits_added,
      )
    }
    _ -> Accum(..acc, index: acc.index + 1)
  }
}

fn process(input: List(String), timesplit: Bool) -> Accum {
  input
  |> list.fold(Accum(dict.new(), 0, 1), fn(acc, char) {
    case char {
      "S" ->
        Accum(dict.insert(acc.beams, acc.index, 1), acc.index + 1, acc.splits)
      "\n" -> Accum(..acc, index: 0)
      "." -> Accum(..acc, index: acc.index + 1)
      "^" -> split_beams(acc, timesplit)
      _ -> panic
    }
  })
}

pub fn part1(input: List(String)) -> Int {
  process(input, False).splits - 1
}

pub fn part2(input: List(String)) -> Int {
  process(input, True).splits
}

pub fn solve(input: String) -> #(Int, Int) {
  let chars = input |> string.to_graphemes
  #(part1(chars), part2(chars))
}
