open Common

type rates = {gamma: string, epsilon: string}
type bitCount = {zeroes: int, ones: int}
type oxygenAndCO2 = {oxygen: array<string>, co2: array<string>}

@val external parseInt: (string, int) => int = "parseInt"

let getBitCounts = lines => {
  let length = switch lines[0] {
  | Some(line) => line->String.length
  | None => failwith("Invalid first line")
  }

  switch length {
  | 0 => failwith("No lines")
  | n =>
    lines->Array.reduce(Array.make(n, {zeroes: 0, ones: 0}), (acc, line) => {
      if line->String.length != n {
        failwith("Lines must all be the same length")
      }

      line
      ->String.split("")
      ->Array.mapWithIndex((i, bit) => {
        let count = Option.getWithDefault(acc[i], {zeroes: 0, ones: 0})

        switch bit {
        | "0" => {...count, zeroes: count.zeroes + 1}
        | "1" => {...count, ones: count.ones + 1}
        | _ => failwith("Invalid bit")
        }
      })
    })
  }
}

let getRates = bitCounts => {
  bitCounts->Array.reduce({gamma: "", epsilon: ""}, (acc, bitCount) => {
    {
      gamma: acc.gamma ++ (bitCount.zeroes > bitCount.ones ? "0" : "1"),
      epsilon: acc.epsilon ++ (bitCount.zeroes < bitCount.ones ? "0" : "1"),
    }
  })
}

let getMostCommon = (bitCounts, position) => {
  switch bitCounts[position] {
  | Some({zeroes, ones}) if zeroes > ones => Some("0")
  | Some({zeroes, ones}) if zeroes < ones => Some("1")
  | Some(_) => Some("1")
  | None => None
  }
}

let getLeastCommon = (bitCounts, position) => {
  switch bitCounts[position] {
  | Some({zeroes, ones}) if zeroes > ones => Some("1")
  | Some({zeroes, ones}) if zeroes < ones => Some("0")
  | Some(_) => Some("0")
  | None => None
  }
}

let getRatings = bitArray => {
  let filter = (bits, position, desired) => {
    bits->Array.keep(bit => {
      switch String.get(bit, position) {
      | Some(ch) => ch == desired
      | _ => false
      }
    })
  }

  let rec loop = (oxygen, co2, position) => {
    switch (oxygen->Array.length, co2->Array.length) {
    | (1, 1) => {oxygen, co2}
    | (1, _) =>
      switch co2->getBitCounts->getLeastCommon(position) {
      | Some(least) => loop(oxygen, filter(co2, position, least), position + 1)
      | None => failwith("Invalid bit count")
      }
    | (_, 1) =>
      switch oxygen->getBitCounts->getMostCommon(position) {
      | Some(most) => loop(filter(oxygen, position, most), co2, position + 1)
      | None => failwith("Invalid bit count")
      }
    | (_, _) =>
      switch (
        oxygen->getBitCounts->getMostCommon(position),
        co2->getBitCounts->getLeastCommon(position),
      ) {
      | (Some(most), Some(least)) =>
        loop(filter(oxygen, position, most), filter(co2, position, least), position + 1)
      | _ => failwith("Invalid bit count")
      }
    }
  }

  loop(bitArray, bitArray, 0)
}

let part1 = rates => {
  parseInt(rates.gamma, 2) * parseInt(rates.epsilon, 2)
}

let part2 = ratings => {
  switch (ratings.oxygen, ratings.co2) {
  | ([ox], [co]) => parseInt(ox, 2) * parseInt(co, 2)
  | _ => failwith("Invalid ratings")
  }
}

let solve = lines => {
  {part1: lines->getBitCounts->getRates->part1, part2: lines->getRatings->part2}
}
