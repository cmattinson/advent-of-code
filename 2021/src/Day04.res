open Common

type cell = {number: int, marked: bool}
type pos = (int, int, int)

type boardState = {
  rows: array<array<cell>>,
  rowCounts: array<int>,
  colCounts: array<int>,
}

type winResult = {board: boardState, lastCalled: int}

type game = {
  numbers: array<int>,
  boards: array<boardState>,
  positions: Belt.Map.t<int, list<pos>, IntCmp.identity>,
}

let initCell = cell => {
  let value = cell->Int.fromString
  switch value {
  | Some(v) => {number: v, marked: false}
  | None => failwith("Invalid cell")
  }
}

let initBoard = boardStr => {
  let rows =
    boardStr
    ->String.split("\n")
    ->Array.map(row => row->String.split(" ")->Array.keep(s => s != "")->Array.map(initCell))
  let size = Array.length(rows)
  {rows, rowCounts: Array.make(size, 0), colCounts: Array.make(size, 0)}
}

let buildPositions = boards =>
  boards->Array.reduceWithIndex(Belt.Map.make(~id=module(IntCmp)), (acc, board, bIdx) =>
    board.rows->Array.reduceWithIndex(acc, (acc, row, rIdx) =>
      row->Array.reduceWithIndex(
        acc,
        (acc, cell, cIdx) =>
          switch acc->Belt.Map.get(cell.number) {
          | Some(list) => acc->Belt.Map.set(cell.number, list{(bIdx, rIdx, cIdx), ...list})
          | None => acc->Belt.Map.set(cell.number, list{(bIdx, rIdx, cIdx)})
          },
      )
    )
  )

let markNumber = (game, called) =>
  switch game.positions->Belt.Map.get(called) {
  | Some(positions) =>
    positions->List.reduce(game, (game, (b, r, c)) => {
      let cell = Array.getExn(Array.getExn(Array.getExn(game.boards, b).rows, r), c)
      if !cell.marked {
        let updateRow = row =>
          row->Array.mapWithIndex((i, cell) => i == c ? {...cell, marked: true} : cell)
        let updateBoard = board => {
          rows: board.rows->Array.mapWithIndex((i, row) => i == r ? updateRow(row) : row),
          rowCounts: board.rowCounts->Array.mapWithIndex((i, v) => i == r ? v + 1 : v),
          colCounts: board.colCounts->Array.mapWithIndex((i, v) => i == c ? v + 1 : v),
        }
        {
          ...game,
          boards: game.boards->Array.mapWithIndex((i, board) =>
            i == b ? updateBoard(board) : board
          ),
        }
      } else {
        game
      }
    })
  | None => game
  }

let initGame = input =>
  switch input->String.split("\n\n")->List.fromArray {
  | list{nums, ...boards} => {
      let boards = boards->List.toArray->Array.map(initBoard)
      {
        numbers: nums
        ->String.split(",")
        ->Array.map(num =>
          switch num->Int.fromString {
          | Some(v) => v
          | None => failwith("Failed to parse game numbers")
          }
        ),
        boards,
        positions: buildPositions(boards),
      }
    }
  | _ => failwith("Invalid game")
  }

let boardWon = board => {
  let size = Array.length(board.rowCounts)
  board.rowCounts->Array.some(count => count == size) ||
    board.colCounts->Array.some(count => count == size)
}

let boardScore = board =>
  board.rows->Array.reduce(0, (sum, row) =>
    row->Array.reduce(sum, (sum, cell) =>
      if cell.marked {
        sum
      } else {
        sum + cell.number
      }
    )
  )

let findWinner = game => game.boards->Array.getBy(boardWon)

let processGame = game => {
  let rec go = (game, i) =>
    if i >= Array.length(game.numbers) {
      failwith("No winner")
    } else {
      let num = Array.getExn(game.numbers, i)
      let game = markNumber(game, num)
      switch findWinner(game) {
      | Some(board) => boardScore(board) * num
      | None => go(game, i + 1)
      }
    }
  go(game, 0)
}

let markWon = (won, i) => won->Array.mapWithIndex((j, w) => j == i ? true : w)

let lastWinner = game => {
  let rec go = (game, i, won, lastWin) =>
    if i >= Array.length(game.numbers) || won->Array.every(w => w) {
      lastWin
    } else {
      let num = Array.getExn(game.numbers, i)
      let game = markNumber(game, num)
      let (won, lastWin) = game.boards->Array.reduceWithIndex((won, lastWin), (
        (won, lastWin),
        board,
        boardIdx,
      ) =>
        if Array.getExn(won, boardIdx) || !boardWon(board) {
          (won, lastWin)
        } else {
          (markWon(won, boardIdx), Some({board, lastCalled: num}))
        }
      )
      go(game, i + 1, won, lastWin)
    }
  go(game, 0, Array.make(Array.length(game.boards), false), None)
}

let solve = input => {
  let game = initGame(input)
  let score1 = processGame(game)
  let score2 = switch lastWinner(game) {
  | Some({board, lastCalled}) => boardScore(board) * lastCalled
  | None => failwith("No winner")
  }

  {part1: score1, part2: score2}
}
