///|
fn part1(input : @string.View) -> Int {
  let lines = input.split("\n")
  for line in lines {
    let split = line.split(" ")
    split..each(println)
  }
  0
}

///|
fn solve(input : @string.View) -> Unit {
  println("Part 1: \{part1(input)}")
  println("Part 2: \{input}")
}

///|
test {
  let contents = @lib.read_file_from_path("inputs/day2-example.txt")
  match contents {
    Ok(contents) => solve(contents)
    Err(e) => println(e)
  }
}
