import gleam/dict.{type Dict}
import gleam/int
import gleam/list.{Continue, Stop}
import gleam/option.{None, Some}
import gleam/result
import gleam/string

type Status {
  On
  Off
}

type Machine {
  Machine(
    current_leds: Dict(Int, Status),
    target_leds: Dict(Int, Status),
    schematics: List(List(Int)),
    current_joltage: Dict(Int, Int),
    target_joltage: Dict(Int, Int),
  )
}

type LEDAccum {
  LEDAccum(current_leds: Dict(Int, Status), target_leds: Dict(Int, Status))
}

type JoltageAccum {
  JoltageAccum(current_joltage: Dict(Int, Int), target_joltage: Dict(Int, Int))
}

fn parse_input(input: List(String)) -> List(Machine) {
  input
  |> list.map(fn(line) {
    let components = string.split(line, " ")

    let diagram = components |> list.first
    let joltage = components |> list.reverse |> list.first
    let schematics =
      components |> list.drop(1) |> list.reverse |> list.drop(1) |> list.reverse

    case diagram, schematics, joltage {
      Ok(diagram), schematics, Ok(joltage) -> {
        let diagrams =
          diagram
          |> string.to_graphemes
          |> list.index_fold(
            LEDAccum(current_leds: dict.new(), target_leds: dict.new()),
            fn(acc, char, index) {
              case char {
                "[" | "]" -> acc
                x -> {
                  case x {
                    "." -> {
                      LEDAccum(
                        current_leds: acc.current_leds
                          |> dict.insert(index - 1, Off),
                        target_leds: acc.target_leds
                          |> dict.insert(index - 1, Off),
                      )
                    }
                    "#" -> {
                      LEDAccum(
                        current_leds: acc.current_leds
                          |> dict.insert(index - 1, Off),
                        target_leds: acc.target_leds
                          |> dict.insert(index - 1, On),
                      )
                    }
                    _ -> panic as "Invalid diagram character"
                  }
                }
              }
            },
          )

        let joltages =
          joltage
          |> string.to_graphemes
          |> list.filter(fn(char) { char != "," })
          |> list.index_fold(
            JoltageAccum(
              current_joltage: dict.new(),
              target_joltage: dict.new(),
            ),
            fn(acc, char, index) {
              case char {
                "{" | "}" | "," -> acc
                x -> {
                  let joltage = int.parse(x) |> result.unwrap(-1)
                  JoltageAccum(
                    current_joltage: acc.current_joltage
                      |> dict.insert(index - 1, 0),
                    target_joltage: acc.target_joltage
                      |> dict.insert(index - 1, joltage),
                  )
                }
              }
            },
          )

        Machine(
          current_leds: diagrams.current_leds,
          target_leds: diagrams.target_leds,
          schematics: schematics
            |> list.map(fn(scheme) {
              scheme
              |> string.to_graphemes
              |> list.fold([], fn(acc, char) {
                case char {
                  "(" | ")" | "," -> acc
                  x -> {
                    let num = int.parse(x) |> result.unwrap(-1)
                    [num, ..acc] |> list.reverse
                  }
                }
              })
            }),
          current_joltage: joltages.current_joltage,
          target_joltage: joltages.target_joltage,
        )
      }
      _, _, _ -> panic as "Invalid line"
    }
  })
}

fn toggle_statuses(
  diagram: Dict(Int, Status),
  buttons: List(List(Int)),
) -> Dict(Int, Status) {
  list.fold(buttons, diagram, fn(diagram, button) {
    list.fold(button, diagram, fn(diagram, index) {
      dict.upsert(diagram, index, fn(status) {
        case status {
          Some(On) -> Off
          Some(Off) -> On
          None -> panic as "Invalid button"
        }
      })
    })
  })
}

fn solve_machine_leds(machine: Machine, count: Int) -> Int {
  let init_state = machine.current_leds
  let combinations = list.combinations(machine.schematics, count)

  let result =
    list.fold_until(combinations, False, fn(state, combination) {
      let new_state = toggle_statuses(init_state, combination)

      case machine.target_leds == new_state {
        True -> Stop(True)
        False -> Continue(state)
      }
    })

  case result {
    True -> count
    False -> {
      solve_machine_leds(machine, count + 1)
    }
  }
}

fn increase_joltages(
  joltages: Dict(Int, Int),
  buttons: List(List(Int)),
) -> Dict(Int, Int) {
  list.fold(buttons, joltages, fn(joltages, button) {
    list.fold(button, joltages, fn(joltages, index) {
      dict.upsert(joltages, index, fn(count) {
        case count {
          Some(num) -> num + 1
          None -> panic as "Invalid button"
        }
      })
    })
  })
}

fn solve_machine_joltage(machine: Machine, count: Int) -> Int {
  let init_joltage = machine.current_joltage
  let combinations = list.combinations(machine.schematics, count)

  let result =
    list.fold_until(combinations, False, fn(state, combination) {
      let new_joltage = increase_joltages(init_joltage, combination)

      case machine.target_joltage == new_joltage {
        True -> Stop(True)
        False -> Continue(state)
      }
    })

  case result {
    True -> count
    False -> {
      solve_machine_joltage(machine, count + 1)
    }
  }
}

fn part1(machines: List(Machine)) -> Int {
  list.fold(machines, 0, fn(acc, machine) {
    acc + solve_machine_leds(machine, 1)
  })
}

fn part2(machines: List(Machine)) -> Int {
  list.fold(machines, 0, fn(acc, machine) {
    acc + solve_machine_joltage(machine, 1)
  })
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  let machines = parse_input(input)
  #(part1(machines), part2(machines))
}
