open Common

type point = {location: (int, int), value: int}

let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]

let parse = input => {
  input->Array.map(row => row->String.split("")->Array.map(parseInt))
}

let getCell = (grid, r, c) => {
  switch grid->Array.get(r) {
  | Some(row) => row->Array.get(c)
  | None => None
  }
}

let isLowPoint = (grid, r, c) => {
  switch grid->getCell(r, c) {
  | Some(cell) =>
    dirs->Array.every(((dr, dc)) => {
      switch grid->getCell(r + dr, c + dc) {
      | Some(neighbor) => neighbor > cell
      | None => true
      }
    })
  | None => false
  }
}

let getLowPoints = grid => {
  grid->Array.reduceWithIndex([], (acc, row, r) => {
    row->Array.reduceWithIndex(acc, (acc, _, c) => {
      if isLowPoint(grid, r, c) {
        acc->Array.concat([
          {location: (r, c), value: grid->getCell(r, c)->Option.getWithDefault(0)},
        ])
      } else {
        acc
      }
    })
  })
}

let findBasinLowPoint = (grid, r, c) => {
  let rec flow = (r, c) => {
    let height = switch grid->getCell(r, c) {
    | Some(h) => h
    | None => failwith("Cell not found")
    }

    let lowestNeighbor = ref((-1, -1))
    let lowestHeight = ref(height)
    dirs->Array.forEach(((dr, dc)) => {
      switch grid->getCell(r + dr, c + dc) {
      | Some(h) if h < lowestHeight.contents =>
        lowestNeighbor := (r + dr, c + dc)
        lowestHeight := h
      | _ => ()
      }
    })

    if lowestHeight.contents == height {
      (r, c)
    } else {
      let (nr, nc) = lowestNeighbor.contents
      flow(nr, nc)
    }
  }

  flow(r, c)
}

let getBasinSizes = grid => {
  let lowPoints = grid->getLowPoints
  let indexMap = Belt.MutableMap.make(~id=module(IntTupleCmp))
  lowPoints->Array.forEachWithIndex((i, lp) => {
    let (r, c) = lp.location
    indexMap->Belt.MutableMap.set((r, c), i)
  })

  let sizes = Belt.Array.make(lowPoints->Array.length, 0)

  grid->Array.forEachWithIndex((r, row) => {
    row->Array.forEachWithIndex((c, cell) => {
      if cell != 9 {
        let (lpR, lpC) = findBasinLowPoint(grid, r, c)
        switch indexMap->Belt.MutableMap.get((lpR, lpC)) {
        | Some(i) =>
          let current = sizes->Array.getExn(i)
          sizes->Array.set(i, current + 1)->ignore
        | None => ()
        }
      }
    })
  })

  sizes
}

let topThree = arr => {
  let first = ref(-1)
  let second = ref(-1)
  let third = ref(-1)

  arr->Array.forEach(value => {
    if value > first.contents {
      third := second.contents
      second := first.contents
      first := value
    } else if value > second.contents {
      third := second.contents
      second := value
    } else if value > third.contents {
      third := value
    }
  })

  (first.contents, second.contents, third.contents)
}

let solve = input => {
  let grid = input->parse
  let lowPoints = grid->getLowPoints
  let part1 = lowPoints->Array.reduce(0, (acc, point) => acc + point.value + 1)

  let (a, b, c) = grid->getBasinSizes->topThree
  let part2 = a * b * c

  {part1, part2}
}
