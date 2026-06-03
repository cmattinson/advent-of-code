///|
fn[T : Eq] every(array : Array[T], values : Array[T]) -> Bool {
  for field in values {
    if array.contains(field) {
      continue
    }
    return false
  }
  return true
}

///|
fn part1(passports : Array[Array[@string.View]]) -> Int {
  passports
  .filter(passport => {
    let present : Set[String] = Set::new()
    let fields : Array[String] = [
      "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid",
    ]
    for entry in passport {
      guard entry.split(":").to_array() is [field, _value] else { panic() }
      present.add(field.to_string())
    }
    return every(fields, present.to_array())
  })
  .length()
}

///|
fn part2(_passports : Array[Array[@string.View]]) -> Int {
  0
}

///|
fn solve(input : @string.View) -> (Int, Int) {
  let passports = input
    .split("\n\n")
    .map(line => line.replace_all(old="\n", new=" ").split(" ").to_array())
    .to_array()
  (part1(passports), part2(passports))
}

///|
test "day 4 example" {
  let contents = @lib.read_file_from_path("inputs/day4-example.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(2, 0)")
    Err(e) => println(e)
  }
}

///|
test "day 4" {
  let contents = @lib.read_file_from_path("inputs/day4.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(133, 0)")
    Err(e) => println(e)
  }
}
