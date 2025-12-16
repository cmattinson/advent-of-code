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

type EquationAccum {
  EquationAccum(equations: List(List(String)), current_equation: List(String))
}

fn parse_equation(lst: List(String)) -> Equation {
  list.fold(lst, Equation(None, []), fn(acc, str) {
    case str {
      "+" -> Equation(Some(Add), acc.digits |> list.reverse)
      "*" -> Equation(Some(Multiply), acc.digits |> list.reverse)
      _ -> {
        case int.parse(str) {
          Ok(digit) -> Equation(acc.operation, [digit, ..acc.digits])
          Error(_) -> Equation(acc.operation, acc.digits)
        }
      }
    }
  })
}

pub fn parse_input_horizontal(input: List(String)) -> List(Equation) {
  input
  |> list.map(fn(str) {
    string.split(str, " ") |> list.filter(fn(s) { s != "" })
  })
  |> list.transpose
  |> list.map(parse_equation)
}

pub fn parse_input_vertical(input: List(String)) -> List(Equation) {
  let equations =
    input
    |> list.map(string.to_graphemes)
    |> list.transpose
    |> list.reverse
    |> list.map(fn(lst) { list.filter(lst, fn(s) { s != " " }) })
    |> list.fold(EquationAccum([], []), fn(acc, col) {
      case col {
        [] -> {
          EquationAccum([acc.current_equation, ..acc.equations], [])
        }
        _ -> {
          let current_equation =
            list.fold(col, #("", ""), fn(acc, s) {
              case s {
                "+" -> #(acc.0, "+")
                "*" -> #(acc.0, "*")
                _ -> #(acc.0 <> s, acc.1)
              }
            })

          case current_equation.1 {
            "" -> {
              EquationAccum(acc.equations, [
                current_equation.0,
                ..acc.current_equation
              ])
            }
            _ -> {
              EquationAccum(acc.equations, [
                current_equation.0,
                current_equation.1,
                ..acc.current_equation
              ])
            }
          }
        }
      }
    })

  list.prepend(equations.equations, equations.current_equation)
  |> list.map(parse_equation)
}

fn process_equation(equation: Equation) -> Int {
  case equation.operation {
    None -> {
      panic as "Invalid equation found"
    }
    Some(Add) ->
      equation.digits
      |> list.fold(0, fn(acc, digit) { acc + digit })
    Some(Multiply) ->
      equation.digits
      |> list.fold(1, fn(acc, digit) { acc * digit })
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
