///|
fn part1(groups : Array[@string.View]) -> Int {
  groups.fold(init=0, (acc, group) => {
    let all = group.replace_all(old="\n", new="")
    let occurences : Set[Char] = Set::new()
    for char in all {
      occurences.add(char)
    }
    acc + occurences.size()
  })
}

///|
fn part2(groups : Array[@string.View]) -> Int {
  groups.fold(init=0, (accum, group) => {
    let person_count = group.split("\n").to_array().length()
    let answers : Map[Char, Int] = Map::new()
    for person in group.split("\n") {
      for char in person {
        answers.set(char, answers.get(char).unwrap_or(0) + 1)
      }
    }
    accum +
    answers
    .values()
    .fold(init=0, (acc, value) => if value == person_count {
      acc + 1
    } else {
      acc
    })
  })
}

///|
fn solve(input : @string.View) -> (Int, Int) {
  let groups = input.split("\n\n").to_array()
  (part1(groups), part2(groups))
}

///|
test "day 6" {
  let contents = @lib.read_file_from_path("inputs/day6.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(6161, 2971)")
    Err(e) => println(e)
  }
}
