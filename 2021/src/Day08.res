open Common

type entry = {signals: array<string>, outputs: array<string>}

let segmentToUniqueDigit = segment => {
  switch segment->String.length {
  | 2 => Some(1)
  | 3 => Some(7)
  | 4 => Some(4)
  | 7 => Some(8)
  | _ => None
  }
}

let segmentToDigit = segment => {
  switch segment->segmentToUniqueDigit {
  | Some(digit) => digit
  | None => {
      let patterns = [
        ("cdfbe", 5),
        ("gcdfa", 2),
        ("fbcad", 3),
        ("cefabd", 9),
        ("cdfgeb", 6),
        ("cagedb", 0),
      ]

      switch Array.getBy(patterns, ((key, _)) =>
        Set.String.eq(
          segment->String.split("")->Set.String.fromArray,
          key->String.split("")->Set.String.fromArray,
        )
      ) {
      | Some((_, digit)) => digit
      | None => failwith("Unknown segment pattern")
      }
    }
  }
}

let parse = input => {
  input->Array.map(line => {
    switch line->String.split(" | ") {
    | [signals, output] => {signals: signals->String.split(" "), outputs: output->String.split(" ")}
    | _ => failwith("Invalid input")
    }
  })
}

let sumUnique = entries => {
  entries->Array.reduce(0, (acc, entry) => {
    entry.outputs->Array.reduce(acc, (acc, output) => {
      switch segmentToUniqueDigit(output) {
      | Some(_) => acc + 1
      | None => acc
      }
    })
  })
}

let getOutputValue = sequence => {
  sequence->Array.reduce(0, (acc, segment) => {
    acc * 10 + segment->segmentToDigit
  })
}

let sumOutputs = entries => {
  entries->Array.reduce(0, (acc, entry) => {
    acc + entry.outputs->getOutputValue
  })
}

let solve = input => {
  let entries = input->parse
  {part1: entries->sumUnique, part2: entries->sumOutputs}
}
