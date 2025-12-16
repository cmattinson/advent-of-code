import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Range {
  Range(start: Int, end: Int)
}

type Ingredients {
  Ingredients(ranges: List(Range), ingredients: List(Int))
}

fn parse_input(input: String) -> Ingredients {
  let #(ranges, ingredients) = case string.split(input, "\n\n") {
    [ranges, ingredients] -> #(ranges, ingredients)
    _ -> panic as "Invalid input"
  }

  let ranges =
    string.split(ranges, "\n")
    |> list.map(fn(range) {
      let #(start, end) = case string.split(range, "-") {
        [start, end] -> #(
          result.unwrap(int.parse(start), -1),
          result.unwrap(int.parse(end), -1),
        )
        _ -> panic as "Invalid range"
      }

      Range(start: start, end: end)
    })

  let ingredients =
    string.split(ingredients, "\n")
    |> list.map(fn(ingredient) { result.unwrap(int.parse(ingredient), -1) })

  Ingredients(ranges, ingredients)
}

fn merge_ranges(ranges: List(Range)) -> List(Range) {
  let sorted =
    list.sort(ranges, fn(a: Range, b: Range) { int.compare(a.start, b.start) })

  list.fold(sorted, [], fn(acc: List(Range), range: Range) {
    case acc {
      [] -> [range]
      [head, ..tail] ->
        case range.start <= head.end + 1 {
          True -> [
            Range(start: head.start, end: int.max(head.end, range.end)),
            ..tail
          ]
          False -> [range, head, ..tail]
        }
    }
  })
  |> list.reverse()
}

fn is_fresh(ranges: List(Range), ingredient: Int) -> Bool {
  list.fold(ranges, False, fn(acc, range) {
    case acc {
      True -> True
      False -> ingredient >= range.start && ingredient <= range.end
    }
  })
}

fn part1(ingredients: Ingredients) -> Int {
  let sorted_ranges =
    ingredients.ranges
    |> merge_ranges
    |> list.sort(fn(a: Range, b: Range) { int.compare(a.start, b.start) })

  list.fold(ingredients.ingredients, 0, fn(acc, ingredient) {
    case is_fresh(sorted_ranges, ingredient) {
      True -> acc + 1
      False -> acc
    }
  })
}

fn part2(ingredients: Ingredients) -> Int {
  ingredients.ranges
  |> merge_ranges
  |> list.fold(0, fn(acc, range) { acc + range.end - range.start + 1 })
}

pub fn solve(input: String) -> #(Int, Int) {
  let ingredients = parse_input(input)
  #(part1(ingredients), part2(ingredients))
}
