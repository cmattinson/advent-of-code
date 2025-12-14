import gleam/int
import gleam/list
import gleam/result
import gleam/string

type MaxValue {
  MaxValue(max: Int, index: Int)
}

fn get_digits(line: String) -> List(Int) {
  line
  |> string.to_graphemes
  |> list.map(fn(char) { result.unwrap(int.parse(char), 0) })
}

fn find_max_with_index(digits: List(Int)) -> MaxValue {
  list.index_fold(digits, MaxValue(max: -1, index: -1), fn(acc, digit, index) {
    case digit > acc.max {
      True -> MaxValue(max: digit, index: index)
      False -> acc
    }
  })
}

fn list_to_int(digits: List(Int)) -> Int {
  list.fold(digits, 0, fn(acc, digit) { acc * 10 + digit })
}

fn sliding_window(
  digits digits: List(Int),
  left left: Int,
  right right: Int,
  max_digits max_digits: List(Int),
) -> List(Int) {
  case list.length(max_digits) == 12 {
    True -> max_digits |> list.reverse
    False -> {
      let current_window =
        digits
        |> list.drop(left)
        |> list.take(right - left + 1)

      let max_in_window = find_max_with_index(current_window)

      let new_left = left + max_in_window.index + 1
      let new_right = int.min(right + 1, list.length(digits) - 1)

      sliding_window(
        digits: digits,
        left: new_left,
        right: new_right,
        max_digits: [max_in_window.max, ..max_digits],
      )
    }
  }
}

fn part1(acc: Int, line: String) -> Int {
  let digits = get_digits(line)

  let suffix_maxs =
    list.fold_right(digits, [], fn(acc, digit) {
      case acc {
        [] -> [digit]
        [head, ..] -> [int.max(digit, head), ..acc]
      }
    })

  let max_value =
    digits
    |> list.zip(list.drop(suffix_maxs, 1))
    |> list.fold(-1, fn(acc, pair) {
      let #(current_digit, suffix_max) = pair
      int.max(acc, current_digit * 10 + suffix_max)
    })

  acc + max_value
}

fn part2(acc: Int, line: String) -> Int {
  let digits = get_digits(line)
  let max_12_digits = sliding_window(digits, 0, list.length(digits) - 12, [])
  acc + list_to_int(max_12_digits)
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  #(list.fold(input, 0, part1), list.fold(input, 0, part2))
}
