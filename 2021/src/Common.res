@module("fs") external readFileSync: (string, string) => string = "readFileSync"

type solution = {part1: int, part2: int}

let readInput = (path: string): string => readFileSync(path, "utf-8")->String.trim

let readLines = (path: string): array<string> => Js.String.split("\n", readInput(path))

// Used for Maps where the key is an int
module IntCmp = Belt.Id.MakeComparable({
  type t = int
  let cmp = (a, b) => a - b
})

// Used for Maps where the key is a tuple of ints
module IntTupleCmp = Belt.Id.MakeComparable({
  type t = (int, int)
  let cmp = ((a1, a2), (b1, b2)) => {
    let c = a1 - b1
    if c == 0 {
      a2 - b2
    } else {
      c
    }
  }
})
