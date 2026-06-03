///|
fn part1(numbers : Array[Int]) -> Int {
  numbers.sort()
  numbers.fold(init=0, (accum, int) => accum + int)
}

///|
fn part2(_numbers : Array[Int]) -> Int {
  0
}

///|
fn solve(input : Array[@string.View]) -> (Int, Int) {
  let numbers = input.map(line => try! @strconv.parse_int(line.to_string()))
  (part1(numbers), part2(numbers))
}

///|
test "day 10 example" {
  let contents = @lib.read_lines_from_path("inputs/day10-example.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(0, 0)")
    Err(e) => println(e)
  }
}

///|
test "day 10 example 2" {
  let contents = @lib.read_lines_from_path("inputs/day10-example-2.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(0, 0)")
    Err(e) => println(e)
  }
}
