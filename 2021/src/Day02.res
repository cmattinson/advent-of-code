open Common

type position = {horizontal: int, depth: int, aim: option<int>}

type direction = Horizontal(int) | Vertical(int)

let parse = instruction => {
  let components = instruction->String.split(" ")

  let unwrap = distance => {
    switch distance->Int.fromString {
    | Some(distance) => distance
    | None => failwith(`Invalid distance - ${distance}`)
    }
  }

  switch components {
  | ["forward", distance] => Horizontal(distance->unwrap)
  | ["down", distance] => Vertical(distance->unwrap)
  | ["up", distance] => Vertical(-(distance->unwrap))
  | _ => failwith(`Invalid instruction - ${instruction}`)
  }
}

let part1 = instructions => {
  let result = instructions->Array.reduce({horizontal: 0, depth: 0, aim: None}, (
    acc,
    instruction,
  ) => {
    switch instruction {
    | Horizontal(distance) => {...acc, horizontal: acc.horizontal + distance}
    | Vertical(distance) => {...acc, depth: acc.depth + distance}
    }
  })

  result.horizontal * result.depth
}

let part2 = instructions => {
  let result = instructions->Array.reduce({horizontal: 0, depth: 0, aim: Some(0)}, (
    acc,
    instruction,
  ) => {
    switch (instruction, acc.aim) {
    | (Horizontal(distance), Some(aim)) => {
        ...acc,
        horizontal: acc.horizontal + distance,
        depth: acc.depth + distance * aim,
      }
    | (Vertical(distance), Some(aim)) => {
        ...acc,
        aim: Some(aim + distance),
      }
    | _ => acc
    }
  })

  result.horizontal * result.depth
}

let solve = lines => {
  let instructions = lines->Array.map(parse)
  {part1: part1(instructions), part2: part2(instructions)}
}
