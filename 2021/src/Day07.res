open Common

let parse = input => {
  input
  ->String.split(",")
  ->Array.map(char =>
    switch char->Int.fromString {
    | Some(value) => value
    | None => failwith("Invalid input")
    }
  )
}

let constantDiff = (crabs, pos) => {
  crabs->Array.reduce(0, (acc, crab) => {
    acc + abs(crab - pos)
  })
}

let sumTo = n => n * (n + 1) / 2

let incrementalDiff = (crabs, pos) => {
  crabs->Array.reduce(0, (acc, crab) => {
    acc + sumTo(abs(crab - pos))
  })
}

let fuelCost = (crabs, diffFunc) => {
  let min = crabs->Array.reduce(max_int, (acc, pos) => pos < acc ? pos : acc)
  let max = crabs->Array.reduce(min_int, (acc, pos) => pos > acc ? pos : acc)

  let rec loop = (i, minFuel) => {
    if i > max {
      minFuel
    } else {
      let fuel = diffFunc(crabs, i)
      loop(
        i + 1,
        if fuel < minFuel {
          fuel
        } else {
          minFuel
        },
      )
    }
  }

  loop(min, max_int)
}

let solve = input => {
  let crabs = parse(input)
  let fuel = fuelCost(crabs, constantDiff)
  let fuel2 = fuelCost(crabs, incrementalDiff)
  {part1: fuel, part2: fuel2}
}
