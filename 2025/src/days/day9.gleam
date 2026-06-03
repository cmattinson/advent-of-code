import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Color {
  None
  Red
  Green
}

type Tile {
  Tile(x: Int, y: Int, color: Color)
}

fn parse_input(input: List(String)) -> List(Tile) {
  input
  |> list.map(fn(s) {
    let split = string.split(s, ",")

    case split {
      [x, y] -> {
        Tile(
          x: int.parse(x) |> result.unwrap(-1),
          y: int.parse(y) |> result.unwrap(-1),
          color: Red,
        )
      }
      _ -> panic as "Invalid input"
    }
  })
}

fn calc_area(corner: Tile, other: Tile) -> Int {
  let x = case corner.x > other.x {
    True -> corner.x - other.x
    False -> other.x - corner.x
  }
  let y = case corner.y > other.y {
    True -> corner.y - other.y
    False -> other.y - corner.y
  }

  { x + 1 } * { y + 1 }
}

fn coordinates_between(corner: Tile, other: Tile) -> List(Tile) {
  let same_row = corner.y == other.y
  let same_column = corner.x == other.x

  case same_row, same_column {
    False, False -> []
    True, True -> []
    True, False -> {
      list.range(int.min(corner.x, other.x) + 1, int.max(corner.x, other.x) - 1)
      |> list.map(fn(x) { Tile(x: x, y: corner.y, color: Green) })
    }
    False, True -> {
      list.range(int.min(corner.y, other.y) + 1, int.max(corner.y, other.y) - 1)
      |> list.map(fn(y) { Tile(x: corner.x, y: y, color: Green) })
    }
  }
}

fn part1(tiles: List(Tile)) -> Int {
  tiles
  |> list.combination_pairs
  |> list.unique
  |> list.map(fn(pair) { calc_area(pair.0, pair.1) })
  |> list.max(int.compare)
  |> result.unwrap(-1)
}

fn part2(tiles: List(Tile)) -> Int {
  let head_and_tail = case
    tiles |> list.first,
    tiles |> list.reverse |> list.first
  {
    Ok(first), Ok(last) -> [first, last]
    _, _ -> panic as "Invalid input"
  }
  tiles
  |> list.sized_chunk(2)
  |> list.reverse
  |> list.prepend(head_and_tail)
  |> list.reverse
  |> list.fold([], fn(acc, pair) {
    case pair {
      [corner, other] -> {
        let greens = coordinates_between(corner, other) |> echo
        list.append(acc, [corner, other, ..greens])
      }
      _ -> panic as "Invalid input"
    }
  })
  |> list.length
  |> echo

  0
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  let tiles =
    input
    |> parse_input
  #(part1(tiles), part2(tiles))
}
