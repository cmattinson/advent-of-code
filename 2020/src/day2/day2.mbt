///|
priv struct Policy {
  letter : Char
  min : Int
  max : Int
} derive(Show)

///|
fn parse_policy(
  count : @string.View,
  letter_view : @string.View
) -> Result[Policy, String] {
  let split = count.split("-").to_array()
  let min = @strconv.parse_int?(split[0].to_string())
  let max = @strconv.parse_int?(split[1].to_string())
  let letter_opt = letter_view[0].to_char()
  match (min, max, letter_opt) {
    (Ok(min), Ok(max), Some(letter)) => Ok(Policy::{ letter, min, max })
    _ => Err("Could not parse policy")
  }
}

///|
fn is_valid_count(policy : Policy, password : @string.View) -> Bool {
  let mut occurrences = 0
  for char in password {
    if char == policy.letter {
      occurrences += 1
    }
  }
  occurrences >= policy.min && occurrences <= policy.max
}

///|
fn is_valid_position(policy : Policy, password : @string.View) -> Bool {
  match
    (
      password[policy.min - 1].to_char().unwrap() == policy.letter,
      password[policy.max - 1].to_char().unwrap() == policy.letter,
    ) {
    (true, false) => true
    (false, true) => true
    _ => false
  }
}

///|
fn count_valid(
  input : @string.View,
  equality_fn : (Policy, @string.View) -> Bool
) -> Int {
  let lines = input.split("\n")
  let mut valid = 0
  for line in lines {
    let split = line.split(" ").to_array()
    if split is [count, letter, password] {
      let policy = parse_policy(count, letter)
      match policy {
        Ok(policy) => if equality_fn(policy, password) { valid += 1 }
        Err(e) => println(e)
      }
    }
  }
  valid
}

///|
fn part1(input : @string.View) -> Int {
  count_valid(input, is_valid_count)
}

///|
fn part2(input : @string.View) -> Int {
  count_valid(input, is_valid_position)
}

///|
fn solve(input : @string.View) -> Unit {
  println("\nDay 2")
  println("Part 1: \{part1(input)}")
  println("Part 2: \{part2(input)}")
}

///|
test {
  let contents = @lib.read_file_from_path("inputs/day2.txt")
  match contents {
    Ok(contents) => solve(contents)
    Err(e) => println(e)
  }
}
