import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string

pub type Operation {
  Add
  Multiply
}

pub type Equation {
  Equation(operation: Option(Operation), digits: List(Int))
}

fn parse_equation(lst: List(String)) -> Equation {
  let reversed_digits =
    list.fold(lst, #(None, []), fn(acc, str) {
      case str {
        "+" -> #(Some(Add), acc.1)
        "*" -> #(Some(Multiply), acc.1)
        _ -> {
          let chars = string.to_graphemes(str)
          case chars {
            [] -> acc
            _ -> {
              let last_char = list.last(chars)
              case last_char {
                Ok(op) if op == "*" || op == "+" -> {
                  let first_chars = list.take(chars, list.length(chars) - 1)
                  let num_str = string.join(first_chars, "")
                  case int.parse(num_str) {
                    Ok(num) -> {
                      let operation = case op {
                        "+" -> Some(Add)
                        "*" -> Some(Multiply)
                        _ -> acc.0
                      }
                      #(operation, [num, ..acc.1])
                    }
                    Error(_) -> acc
                  }
                }
                _ -> {
                  case int.parse(str) {
                    Ok(digit) -> #(acc.0, [digit, ..acc.1])
                    Error(_) -> acc
                  }
                }
              }
            }
          }
        }
      }
    })

  Equation(reversed_digits.0, list.reverse(reversed_digits.1))
}

pub fn parse_input_horizontal(input: List(String)) -> List(Equation) {
  input
  |> list.map(string.split(_, " "))
  |> list.map(list.filter(_, fn(s) { !string.is_empty(s) }))
  |> list.transpose
  |> list.map(parse_equation)
}

type SplitAccum {
  SplitAccum(chunks: List(List(String)), current: List(String))
}

fn split_list(
  lst: List(List(String)),
  separator: List(String),
) -> List(List(String)) {
  let result =
    list.fold(lst, SplitAccum([], []), fn(acc, item) {
      case item == separator {
        True -> SplitAccum([list.reverse(acc.current), ..acc.chunks], [])
        False -> SplitAccum(acc.chunks, [string.join(item, ""), ..acc.current])
      }
    })

  list.reverse([list.reverse(result.current), ..result.chunks])
}

pub fn parse_input_vertical(input: List(String)) -> List(Equation) {
  input
  |> list.map(string.to_graphemes)
  |> list.transpose
  |> list.map(list.filter(_, fn(s) { s != " " }))
  |> split_list([])
  |> list.map(parse_equation)
}

fn process_equation(equation: Equation) -> Int {
  case equation.operation {
    None -> panic as "Invalid equation found"
    Some(Add) -> list.fold(equation.digits, 0, fn(acc, digit) { acc + digit })
    Some(Multiply) ->
      list.fold(equation.digits, 1, fn(acc, digit) { acc * digit })
  }
}

fn part1(input: List(String)) -> Int {
  input
  |> parse_input_horizontal
  |> list.fold(0, fn(acc, equation) { acc + process_equation(equation) })
}

fn part2(input: List(String)) -> Int {
  input
  |> parse_input_vertical
  |> list.fold(0, fn(acc, equation) { acc + process_equation(equation) })
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  #(part1(input), part2(input))
}
