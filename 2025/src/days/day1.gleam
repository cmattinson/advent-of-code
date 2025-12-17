import gleam/int
import gleam/list
import gleam/result

type Direction {
  Left
  Right
}

type Accum {
  Accum(dial: Int, at_zero: Int)
}

fn parse_line(line: String) -> Result(Int, String) {
  case line {
    "L" <> value -> {
      case int.parse(value) {
        Ok(res) -> Ok(-res)
        Error(_) -> Error("Invalid number" <> " " <> value)
      }
    }
    "R" <> value -> {
      case int.parse(value) {
        Ok(res) -> Ok(res)
        Error(_) -> Error("Invalid number" <> " " <> value)
      }
    }
    _ -> Error("Invalid line" <> " " <> line)
  }
}

fn get_next_value(dial: Int, value: Int) -> Int {
  result.unwrap(int.modulo(dial + value, 100), -1)
}

fn count_zeros_in_range(start: Int, step: Int, ticks: Int) -> Int {
  case ticks <= 0 {
    True -> 0
    False -> {
      let next = result.unwrap(int.modulo(start + step, 100), -1)

      case next {
        0 -> 1 + count_zeros_in_range(start + step, step, ticks - 1)
        _ -> count_zeros_in_range(start + step, step, ticks - 1)
      }
    }
  }
}

fn tick(dial: Int, ticks: Int, zeros: Int, direction: Direction) -> #(Int, Int) {
  case ticks {
    0 -> #(dial, zeros)
    _ -> {
      let step = case direction {
        Left -> -1
        Right -> 1
      }

      let final_dial = result.unwrap(int.modulo(dial + step * ticks, 100), -1)
      let zero_count = count_zeros_in_range(dial, step, ticks)

      #(final_dial, zeros + zero_count)
    }
  }
}

fn part1(accum: Accum, line: String) -> Accum {
  let assert Ok(value) = parse_line(line)
  let next_value = get_next_value(accum.dial, value)
  case next_value {
    0 -> Accum(dial: next_value, at_zero: accum.at_zero + 1)
    _ -> Accum(dial: next_value, at_zero: accum.at_zero)
  }
}

fn part2(accum: Accum, line: String) -> Accum {
  let assert Ok(value) = parse_line(line)
  case value > 0 {
    True -> {
      let #(final_dial, zero_count) =
        tick(accum.dial, int.absolute_value(value), 0, Right)
      Accum(dial: final_dial, at_zero: accum.at_zero + zero_count)
    }
    False -> {
      let #(final_dial, zero_count) =
        tick(accum.dial, int.absolute_value(value), 0, Left)
      Accum(dial: final_dial, at_zero: accum.at_zero + zero_count)
    }
  }
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  #(
    list.fold(input, Accum(dial: 50, at_zero: 0), part1).at_zero,
    list.fold(input, Accum(dial: 50, at_zero: 0), part2).at_zero,
  )
}
