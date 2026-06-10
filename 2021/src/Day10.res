type solution = {part1: int, part2: bigint}
type lineType = Complete | Incomplete(list<string>) | Corrupted(int)

let isOpening = char =>
  switch char {
  | "(" | "[" | "{" | "<" => true
  | ")" | "]" | "}" | ">" => false
  | _ => false
  }

let scoreLine = illegal =>
  switch illegal {
  | ")" => 3
  | "]" => 57
  | "}" => 1197
  | ">" => 25137
  | _ => 0
  }

let getMatch = char =>
  switch char {
  | ")" => "("
  | "]" => "["
  | "}" => "{"
  | ">" => "<"
  | "(" => ")"
  | "[" => "]"
  | "{" => "}"
  | "<" => ">"
  | _ => ""
  }

let getLineType = line => {
  let rec loop = (remaining, stack) => {
    switch (remaining, stack) {
    | (list{}, list{}) => Complete
    | (list{}, stack) => Incomplete(stack)
    | (list{next, ...tl}, list{}) =>
      if isOpening(next) {
        loop(tl, list{next, ...stack})
      } else {
        Corrupted(scoreLine(next))
      }
    | (list{next, ...tl}, list{lastOpen, ...s}) =>
      if isOpening(next) {
        loop(tl, list{next, ...stack})
      } else if getMatch(next) == lastOpen {
        loop(tl, s)
      } else {
        Corrupted(scoreLine(next))
      }
    }
  }

  loop(line->String.split("")->List.fromArray, list{})
}

let scoreStack = stack => {
  stack->Array.reduce(0n, (acc, char) =>
    switch char {
    | ")" => acc * 5n + 1n
    | "]" => acc * 5n + 2n
    | "}" => acc * 5n + 3n
    | ">" => acc * 5n + 4n
    | _ => acc
    }
  )
}

let findMiddle = scores => {
  let sorted = scores->SortArray.stableSortBy((a, b) => {
    if a < b {
      -1
    } else if a > b {
      1
    } else {
      0
    }
  })

  let length = Array.length(sorted)
  switch sorted[length / 2] {
  | Some(middle) => Some(middle)
  | None => None
  }
}

let part1 = types => {
  types->Array.reduce(0, (acc, line) => {
    switch line {
    | Corrupted(score) => acc + score
    | _ => acc
    }
  })
}

let part2 = types => {
  let result =
    types
    ->Array.reduce([], (acc, line) =>
      switch line {
      | Incomplete(stack) =>
        Array.concat(acc, [stack->List.map(getMatch)->List.toArray->scoreStack])
      | _ => acc
      }
    )
    ->findMiddle
  switch result {
  | Some(middle) => middle
  | None => 0n
  }
}

let solve = lines => {
  let types = lines->Array.map(getLineType)
  {part1: types->part1, part2: types->part2}
}
