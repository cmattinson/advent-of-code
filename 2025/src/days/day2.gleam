import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Range {
  Range(start: Int, end: Int)
}

fn parse_range(input: String) -> Range {
  let values = string.split(input, "-") |> list.map(int.parse)
  case values {
    [Ok(start), Ok(end)] -> Range(start: start, end: end)
    _ -> panic as "Invalid range"
  }
}

fn parse_input(input: String) -> List(Range) {
  string.split(input, ",") |> list.map(parse_range)
}

fn digits_from_value_helper(value: Int, acc: List(Int)) -> List(Int) {
  case value {
    0 -> acc
    _ -> digits_from_value_helper(value / 10, [value % 10, ..acc])
  }
}

fn digits_from_value(value: Int) -> List(Int) {
  case value {
    0 -> [0]
    _ -> digits_from_value_helper(value, [])
  }
}

fn get_invalid_sum(
  range: Range,
  is_invalid: fn(List(Int)) -> Bool,
  invalid_sum: Int,
) -> Int {
  case range.start > range.end {
    True -> invalid_sum
    False -> {
      let digits = digits_from_value(range.start)
      case is_invalid(digits) {
        True -> {
          get_invalid_sum(
            Range(start: range.start + 1, end: range.end),
            is_invalid,
            invalid_sum + range.start,
          )
        }
        False ->
          get_invalid_sum(
            Range(start: range.start + 1, end: range.end),
            is_invalid,
            invalid_sum,
          )
      }
    }
  }
}

pub fn sequence_repeats(digits: List(Int)) -> Bool {
  let length = list.length(digits)
  case length % 2 == 0 {
    False -> False
    True -> {
      let half = length / 2
      let chunk1 = list.take(digits, half)
      let chunk2 = list.drop(digits, half)
      chunk1 == chunk2
    }
  }
}

fn find_smallest_pattern_length(
  digits: List(Int),
  total_length: Int,
  current: Int,
) -> Int {
  case current > total_length / 2 {
    True -> total_length
    False -> {
      case total_length % current == 0 {
        False -> find_smallest_pattern_length(digits, total_length, current + 1)
        True -> {
          let pattern = list.take(digits, current)
          case is_pattern_repeated(digits, pattern) {
            True -> current
            False ->
              find_smallest_pattern_length(digits, total_length, current + 1)
          }
        }
      }
    }
  }
}

fn is_pattern_repeated(digits: List(Int), pattern: List(Int)) -> Bool {
  let pattern_length = list.length(pattern)
  let chunks = list.sized_chunk(digits, into: pattern_length)
  list.all(chunks, fn(chunk) { chunk == pattern })
}

pub fn sequence_repeats_at_least_twice(digits: List(Int)) -> Bool {
  case digits {
    [] -> False
    _ -> {
      let length = list.length(digits)
      let pattern_length = find_smallest_pattern_length(digits, length, 1)
      let chunks = list.sized_chunk(digits, into: pattern_length)
      let head = result.unwrap(list.first(chunks), [])
      list.length(chunks) > 1 && list.all(chunks, fn(chunk) { chunk == head })
    }
  }
}

fn part1(acc: Int, range: Range) -> Int {
  acc + get_invalid_sum(range, sequence_repeats, 0)
}

fn part2(acc: Int, range: Range) -> Int {
  acc + get_invalid_sum(range, sequence_repeats_at_least_twice, 0)
}

pub fn solve(input: String) -> #(Int, Int) {
  let ranges = parse_input(input)
  #(list.fold(ranges, 0, part1), list.fold(ranges, 0, part2))
}
