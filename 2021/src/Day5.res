open Common

type coordinate = (int, int)
type line = {start: coordinate, end: coordinate}
type lineDirection = Horizontal | Vertical | Diagonal

let unwrapInt = str => {
  switch str->Int.fromString {
  | Some(v) => v
  | None => failwith(`Invalid int: ${str}`)
  }
}

let constructLine = str => {
  let split = String.split(str, " -> ")

  switch split {
  | [start, end] =>
    switch (start->String.split(","), end->String.split(",")) {
    | ([startX, startY], [endX, endY]) => {
        start: (unwrapInt(startX), unwrapInt(startY)),
        end: (unwrapInt(endX), unwrapInt(endY)),
      }
    | _ => failwith("Invalid line")
    }
  | _ => failwith("Invalid line")
  }
}

let example = value => value + 0

let getLineDirection = line => {
  switch (line.start, line.end) {
  | ((x1, y1), (x2, y2)) =>
    switch (x1 == x2, y1 == y2) {
    | (true, false) => Vertical
    | (false, true) => Horizontal
    | _ => Diagonal
    }
  }
}

let addLinePoints = (map, minI, maxI, makeCoord) => {
  let rec go = (map, i) => {
    if i > maxI {
      map
    } else {
      let coord = makeCoord(i)
      let count = switch map->Belt.Map.get(coord) {
      | Some(c) => c + 1
      | None => 1
      }
      go(map->Belt.Map.set(coord, count), i + 1)
    }
  }

  go(map, minI)
}

let addCoordinates = (~includeDiagonals=false, map, line) => {
  let ((x1, y1), (x2, y2)) = (line.start, line.end)

  switch getLineDirection(line) {
  | Horizontal => addLinePoints(map, min(x1, x2), max(x1, x2), i => (i, y1))
  | Vertical => addLinePoints(map, min(y1, y2), max(y1, y2), i => (x1, i))
  | Diagonal if includeDiagonals => {
      let steps = abs(x1 - x2)

      let xStep = if x1 < x2 {
        1
      } else {
        -1
      }
      let yStep = if y1 < y2 {
        1
      } else {
        -1
      }

      addLinePoints(map, 0, steps, i => (x1 + i * xStep, y1 + i * yStep))
    }
  | Diagonal => map
  }
}

let countOverlaps = (lines, ~includeDiagonals) =>
  lines
  ->Array.reduce(Belt.Map.make(~id=module(IntTupleCmp)), (acc, line) =>
    addCoordinates(~includeDiagonals, acc, line)
  )
  ->Map.reduce(0, (acc, _, v) =>
    if v >= 2 {
      acc + 1
    } else {
      acc
    }
  )

let solve = input => {
  let lines = input->Array.map(constructLine)
  let part1 = lines->countOverlaps(~includeDiagonals=false)
  let part2 = lines->countOverlaps(~includeDiagonals=true)
  {part1, part2}
}
