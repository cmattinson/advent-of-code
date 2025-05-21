///|
fn part1(digits : Array[Int]) -> Int {
  let map : Map[Int, Int] = Map::new()
  let mut num1 = 0
  let mut num2 = 0
  for i = 0; i < digits.length(); i = i + 1 {
    let current = digits[i]
    let target = 2020 - current
    if map.contains(target) {
      num1 = target
      num2 = current
    }
    map.set(current, i)
  }
  num1 * num2
}

///|
fn part2(digits : Array[Int]) -> Int {
  digits.sort()
  let length = digits.length()
  let mut result : Int = 1
  for i = 0; i < digits.length() - 1; i = i + 1 {
    let mut left = i + 1
    let mut right = length - 1
    while left < right {
      let current_sum = digits[i] + digits[left] + digits[right]
      if current_sum == 2020 {
        result = digits[i] * digits[left] * digits[right]
        break
      } else if current_sum < 2020 {
        left += 1
      } else {
        right -= 1
      }
    }
  }
  result
}

///|
fn solve(input : @string.View) -> (Int, Int) {
  let digits = input
    .split("\n")
    .map(fn(line) {
      let digit = @strconv.parse_int?(line.to_string())
      match digit {
        Ok(d) => d
        Err(_) => 0
      }
    })
    .to_array()
  (part1(digits), part2(digits))
}

///|
test "day 1" {
  let contents = @lib.read_file_from_path("inputs/day1.txt")
  match contents {
    Ok(contents) => inspect!(solve(contents), content="(259716, 120637440)")
    Err(e) => println(e)
  }
}
