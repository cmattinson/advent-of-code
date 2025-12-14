import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Position {
  Position(row: Int, col: Int)
}

type Grid {
  Grid(rows: Int, cols: Int, cells: List(List(String)))
}

type Cell {
  At
  Empty
}

fn parse_grid(lines: List(String)) -> Grid {
  let cells = list.map(lines, string.to_graphemes)
  let rows = list.length(lines)
  let cols = cells |> list.first |> result.unwrap([]) |> list.length

  Grid(rows, cols, cells)
}

fn get_cell_at(grid: Grid, pos: Position) -> Cell {
  case list.drop(grid.cells, pos.row) {
    [row, ..] -> {
      case list.drop(row, pos.col) {
        ["@", ..] -> At
        _ -> Empty
      }
    }
    [] -> Empty
  }
}

fn get_valid_at_neighbors(grid: Grid, pos: Position) -> List(Position) {
  let row_min = int.max(0, pos.row - 1)
  let row_max = int.min(grid.rows - 1, pos.row + 1)
  let col_min = int.max(0, pos.col - 1)
  let col_max = int.min(grid.cols - 1, pos.col + 1)

  list.range(row_min, row_max)
  |> list.flat_map(fn(row) {
    list.range(col_min, col_max)
    |> list.filter_map(fn(col) {
      let neighbor = Position(row, col)
      case neighbor == pos || get_cell_at(grid, neighbor) != At {
        True -> Error(Nil)
        False -> Ok(neighbor)
      }
    })
  })
}

fn count_at_neighbors(grid: Grid, pos: Position) -> Int {
  get_valid_at_neighbors(grid, pos) |> list.length
}

fn find_all_at_positions(grid: Grid) -> List(Position) {
  list.range(0, grid.rows - 1)
  |> list.flat_map(fn(row) {
    list.range(0, grid.cols - 1)
    |> list.filter_map(fn(col) {
      let pos = Position(row, col)
      case get_cell_at(grid, pos) {
        At -> Ok(pos)
        Empty -> Error(Nil)
      }
    })
  })
}

fn remove_cell(grid: Grid, pos: Position) -> Grid {
  let new_cells =
    list.index_map(grid.cells, fn(row, row_idx) {
      case row_idx == pos.row {
        True ->
          list.index_map(row, fn(cell, col_idx) {
            case col_idx == pos.col {
              True -> "."
              False -> cell
            }
          })
        False -> row
      }
    })
  Grid(rows: grid.rows, cols: grid.cols, cells: new_cells)
}

fn remove_cells(
  grid: Grid,
  current_positions: List(Position),
  removed_count: Int,
) -> Int {
  let qualifying_cells =
    current_positions
    |> list.filter(fn(pos) { count_at_neighbors(grid, pos) < 4 })

  case qualifying_cells {
    [] -> removed_count
    _ -> {
      let batch_size = list.length(qualifying_cells)
      let new_grid = list.fold(qualifying_cells, grid, remove_cell)
      let new_positions =
        list.filter(current_positions, fn(pos) {
          get_cell_at(new_grid, pos) == At
        })
      remove_cells(new_grid, new_positions, removed_count + batch_size)
    }
  }
}

fn part1(grid: Grid) -> Int {
  grid
  |> find_all_at_positions
  |> list.filter(fn(pos) { count_at_neighbors(grid, pos) < 4 })
  |> list.length
}

fn part2(grid: Grid) -> Int {
  let at_positions = find_all_at_positions(grid)
  remove_cells(grid, at_positions, 0)
}

pub fn solve(input: String) -> #(Int, Int) {
  let grid = input |> string.split("\n") |> parse_grid
  #(part1(grid), part2(grid))
}
