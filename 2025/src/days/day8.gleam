import gleam/dict
import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/set
import gleam/string

pub type JunctionBox {
  JunctionBox(x: Int, y: Int, z: Int)
}

pub type Pair {
  Pair(a: JunctionBox, b: JunctionBox, distance: Float)
}

fn calculate_distance(box: JunctionBox, from: JunctionBox) -> Float {
  let x = box.x - from.x
  let y = box.y - from.y
  let z = box.z - from.z

  let assert Ok(x_squared) = int.power(x, 2.0)
  let assert Ok(y_squared) = int.power(y, 2.0)
  let assert Ok(z_squared) = int.power(z, 2.0)
  let assert Ok(result) = float.square_root(x_squared +. y_squared +. z_squared)

  result
}

pub fn parse_junction_box(input: String) -> JunctionBox {
  let box = case string.split(input, ",") {
    [x, y, z] -> {
      use x <- result.try(int.parse(x))
      use y <- result.try(int.parse(y))
      use z <- result.try(int.parse(z))
      Ok(JunctionBox(x, y, z))
    }
    _ -> Error(Nil)
  }

  let assert Ok(box) = box
  box
}

fn parse_input(
  input: List(String),
  count: Int,
) -> #(List(Pair), List(List(JunctionBox))) {
  let boxes = input |> list.map(parse_junction_box)

  let pairs =
    boxes
    |> list.combination_pairs
    |> list.map(fn(pair) {
      Pair(pair.0, pair.1, calculate_distance(pair.0, pair.1))
    })
    |> list.sort(fn(a, b) { float.compare(a.distance, b.distance) })
    |> list.take(count)

  let circuits =
    list.fold(pairs, [], fn(acc, pair) { [[pair.b], [pair.a], ..acc] })
    |> list.reverse
    |> list.unique

  #(pairs, circuits)
}

type ConnectionAccum {
  ConnectionAccum(
    circuits: List(List(JunctionBox)),
    connected: dict.Dict(JunctionBox, List(JunctionBox)),
  )
}

fn add_to_circuits(
  a: JunctionBox,
  b: JunctionBox,
  accum: ConnectionAccum,
) -> ConnectionAccum {
  let a_connection = dict.get(accum.connected, a) |> result.unwrap([])
  let b_connection = dict.get(accum.connected, b) |> result.unwrap([])

  let a_length = list.length(a_connection)
  let b_length = list.length(b_connection)

  case a_connection, b_connection {
    [], _ -> {
      accum
    }
    _, [] -> accum
    _, _ if a_length >= b_length -> {
      let new_connection = list.append(a_connection, b_connection)
      ConnectionAccum(
        accum.circuits,
        accum.connected
          |> dict.delete(b)
          |> dict.insert(a, new_connection),
      )
    }
    _, _ -> {
      let new_connection = list.append(b_connection, a_connection)
      ConnectionAccum(
        accum.circuits,
        accum.connected
          |> dict.delete(a)
          |> dict.insert(b, new_connection),
      )
    }
  }
}

pub fn part1(pairs: List(Pair), circuits: List(List(JunctionBox))) -> Int {
  let connection_dict =
    list.fold(circuits, dict.new(), fn(acc, circuit) {
      case list.first(circuit) {
        Ok(head) -> {
          acc |> dict.insert(head, circuit)
        }
        Error(_) -> panic as "Invalid circuit"
      }
    })

  let connections =
    list.fold(pairs, ConnectionAccum(circuits, connection_dict), fn(acc, pair) {
      add_to_circuits(pair.a, pair.b, acc)
    }).connected
    |> dict.values

  // connections
  // |> list.unique
  // |> list.sort(fn(a, b) { int.compare(list.length(b), list.length(a)) })
  // |> list.take(3)
  // |> list.fold(1, fn(acc, circuit) { acc * list.length(circuit) })

  0
}

pub fn part2(pairs: List(Pair), circuits: List(List(JunctionBox))) -> Int {
  0
}

pub fn solve_example(input: List(String)) -> #(Int, Int) {
  let #(pairs, circuits) = parse_input(input, 10)

  #(part1(pairs, circuits), part2(pairs, circuits))
}

pub fn solve(input: List(String)) -> #(Int, Int) {
  let #(pairs, circuits) = parse_input(input, 1000)
  #(part1(pairs, circuits), part2(pairs, circuits))
}
