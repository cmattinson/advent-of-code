import gleam/dict.{type Dict}
import gleam/list
import gleam/result
import gleam/set.{type Set}
import gleam/string

type DeviceMap =
  Dict(String, List(String))

fn parse_input(input: List(String)) -> DeviceMap {
  input
  |> list.fold(dict.new(), fn(acc, line) {
    case string.split(line, " ") {
      [name, ..rest] -> {
        let key = name |> string.drop_end(1)

        acc |> dict.insert(key, rest)
      }
      _ -> acc
    }
  })
}

fn paths_to_out(map: DeviceMap, key: String, current: Int) -> Int {
  case map |> dict.get(key) {
    Ok(["out"]) -> current + 1
    Ok(rest) -> {
      current
      + list.fold(rest, 0, fn(acc, item) { paths_to_out(map, item, acc) })
    }
    Error(_) -> 0
  }
}

fn paths_through_transforms(
  map: DeviceMap,
  key: String,
  current: Int,
  dac: Bool,
  fft: Bool,
  visited: Set(String),
) {
  case visited |> set.contains(key) {
    True -> {
      current
    }
    False -> {
      case map |> dict.get(key) {
        Ok(["out"]) -> {
          case dac && fft {
            True -> current + 1
            False -> current
          }
        }
        Ok(rest) -> {
          case
            list.contains(rest, "dac") || dac,
            list.contains(rest, "fft") || fft
          {
            has_dac, has_fft -> {
              current
              + list.fold(rest, 0, fn(acc, item) {
                paths_through_transforms(
                  map,
                  item,
                  acc,
                  has_dac,
                  has_fft,
                  visited |> set.insert(key),
                )
              })
            }
          }
        }
        Error(_) -> 0
      }
    }
  }
}

pub fn part1(devices: DeviceMap) -> Int {
  devices
  |> paths_to_out("you", 0)
}

pub fn part2(devices: DeviceMap) -> Int {
  devices
  |> dict.get("svr")
  |> result.unwrap([])
  |> list.map(fn(starting_point) {
    echo starting_point
    paths_through_transforms(
      devices,
      starting_point,
      0,
      False,
      False,
      set.new(),
    )
  })
  |> list.fold(0, fn(acc, item) { acc + item })
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  let devices = parse_input(input)
  #(part1(devices), part2(devices))
}
