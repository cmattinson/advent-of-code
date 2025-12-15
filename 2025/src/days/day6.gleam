import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string

type Character {
  Digit(Int)
  Operator(String)
}

type Accum {
  Accum(current_digit: Option(Int), problem_characters: List(Character))
}

type Operation {
  Add
  Multiply
}

type VerticalAccum {
  VerticalAccum(
    overall_result: Int,
    problem_digits: List(Int),
    operation: Option(Operation),
  )
}

fn accumulate_digit(current: Option(Int), new_digit: Int) -> Int {
  case current {
    Some(existing) -> existing * 10 + new_digit
    None -> new_digit
  }
}

fn process_digit(char: String, is_last: Bool, acc: Accum) -> Accum {
  case int.parse(char) {
    Ok(digit) -> {
      let new_digit = accumulate_digit(acc.current_digit, digit)
      case is_last {
        True ->
          Accum(Some(new_digit), [Digit(new_digit), ..acc.problem_characters])
        False -> Accum(Some(new_digit), acc.problem_characters)
      }
    }
    Error(_) -> acc
  }
}

fn process_operator(char: String, acc: Accum) -> Accum {
  Accum(None, [Operator(char), ..acc.problem_characters])
}

fn parse_line_horizontal(line: String) -> List(Character) {
  let line_length = string.length(line)
  let result =
    list.index_fold(
      string.to_graphemes(line),
      Accum(None, []),
      fn(acc, char, char_index) {
        case char {
          "*" | "+" -> process_operator(char, acc)
          " " -> {
            case acc.current_digit {
              None -> acc
              Some(digit) ->
                Accum(None, [Digit(digit), ..acc.problem_characters])
            }
          }
          _ -> {
            process_digit(char, char_index == line_length - 1, acc)
          }
        }
      },
    )

  result.problem_characters
}

fn parse_input_horizontal(input: List(String)) -> List(List(Character)) {
  list.fold(input, [], fn(acc, line) {
    let digits = parse_line_horizontal(line)
    [list.reverse(digits), ..acc]
  })
}

fn build_digit(digits: List(String)) -> Int {
  list.fold(digits |> list.reverse, 0, fn(acc, digit) {
    case int.parse(digit) {
      Ok(digit) -> acc * 10 + digit
      Error(_) -> acc
    }
  })
}

fn parse_input_vertical(input: List(String)) -> Int {
  let input_grid =
    list.map(input, string.to_graphemes) |> list.transpose |> list.reverse
  list.fold(input_grid, VerticalAccum(0, [], None), fn(acc, line) {
    let digits_and_ops =
      list.filter(line, fn(char) { char != " " }) |> list.reverse
    let new_acc = case digits_and_ops {
      ["+", ..rest] -> {
        VerticalAccum(0, [build_digit(rest), ..acc.problem_digits], Some(Add))
      }
      ["*", ..rest] -> {
        VerticalAccum(
          1,
          [build_digit(rest), ..acc.problem_digits],
          Some(Multiply),
        )
      }
      digits -> {
        case digits {
          [digit, ..rest] -> {
            let digits = [digit, ..rest]
            VerticalAccum(
              acc.overall_result,
              [build_digit(digits), ..acc.problem_digits],
              acc.operation,
            )
          }
          [] -> {
            case acc.operation {
              Some(Add) ->
                VerticalAccum(
                  acc.overall_result
                    + list.fold(acc.problem_digits, 0, fn(acc, digit) {
                    digit + acc
                  }),
                  [],
                  None,
                )
              Some(Multiply) ->
                VerticalAccum(
                  acc.overall_result
                    * list.fold(acc.problem_digits, 1, fn(acc, digit) {
                    digit * acc
                  }),
                  [],
                  None,
                )
              None -> acc
            }
          }
        }
      }
    }

    case new_acc.operation {
      None -> new_acc
      Some(Add) ->
        VerticalAccum(
          acc.overall_result
            + list.fold(new_acc.problem_digits, 0, fn(acc, digit) {
            digit + acc
          }),
          [],
          None,
        )
      Some(Multiply) ->
        VerticalAccum(
          acc.overall_result
            + 1
            * list.fold(new_acc.problem_digits, 1, fn(acc, digit) {
            digit * acc
          }),
          [],
          None,
        )
    }
  }).overall_result
}

fn part1(input: List(String)) -> Int {
  let parsed = parse_input_horizontal(input)
  list.fold(list.transpose(parsed), 0, fn(acc, line) {
    case line {
      [Operator("+"), ..rest] -> {
        acc
        + list.fold(rest, 0, fn(acc, char) {
          case char {
            Digit(digit) -> acc + digit
            Operator(_) -> 0
          }
        })
      }
      [Operator("*"), ..rest] -> {
        acc
        + list.fold(rest, 1, fn(acc, char) {
          case char {
            Digit(digit) -> acc * digit
            Operator(_) -> 1
          }
        })
      }
      _ -> acc
    }
  })
}

fn part2(input: List(String)) -> Int {
  parse_input_vertical(input)
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  #(part1(input), part2(input))
}
