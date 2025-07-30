///|
fn part1(lines : Array[@string.View]) -> Int {
  let mut total = 0
  let mut index = 0
  let visited : Map[Int, Bool] = {}
  while true {
    guard visited.get(index) is None &&
      lines[index].split(" ").to_array() is [instruction, value] else {
      break
    }
    visited.set(index, true)
    match (instruction, try? @strconv.parse_int(value.to_string())) {
      ("nop", _) => index += 1
      ("acc", Ok(val)) => {
        total += val
        index += 1
      }
      ("jmp", Ok(val)) =>
        if index + val < 0 {
          index = 0
        } else if index + val >= lines.length() {
          index = lines.length() - 1
        } else {
          index += val
        }
      _ => ()
    }
  }
  total
}

///|
fn part2(_lines : Array[@string.View]) -> Int {
  0
}

///|
fn solve(input : @string.View) -> (Int, Int) {
  let lines = input.split("\n").to_array()
  (part1(lines), part2(lines))
}

///|
test "day 8 example" {
  let contents = @lib.read_file_from_path("inputs/day8-example.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(5, 0)")
    Err(e) => println(e)
  }
}

///|
test "day 8" {
  let contents = @lib.read_file_from_path("inputs/day8.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(1337, 0)")
    Err(e) => println(e)
  }
}
