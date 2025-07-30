///|
fn part1(nums : Array[Int64], preamble_length : Int) -> Int64 {
  let mut invalid : Int64 = -1
  for i = preamble_length; i < nums.length(); i = i + 1 {
    let check : ArrayView[Int64] = nums[i - preamble_length:i]
    if !check.any(candidate => check.contains(nums[i] - candidate)) {
      invalid = nums[i]
      break
    }
  }
  invalid
}

///|
fn part2(nums : Array[Int64], invalid_number : Int64) -> Int64 {
  let length = nums.length()
  let subsequences : Array[ArrayView[Int64]] = []
  for i = 0; i < length - 1; i = i + 1 {
    for j = i + 1; j < length; j = j + 1 {
      subsequences.push(nums[i:j + 1])
    }
  }
  let mut min = @int64.max_value
  let mut max = @int64.min_value
  for sequence in subsequences {
    if sequence.fold(init=0L, (accum, curr) => accum + curr) == invalid_number {
      for val in sequence {
        if val < min {
          min = val
        }
        if val > max {
          max = val
        }
      }
    }
  }
  return min + max
}

///|
fn solve(input : @string.View, preamble_length : Int) -> (Int64, Int64) raise {
  let lines = input.split("\n").to_array()
  let nums = lines.map(num => @strconv.parse_int64(num.to_string()))
  let invalid_number = part1(nums, preamble_length)
  (invalid_number, part2(nums, invalid_number))
}

///|
test "day 9 example" {
  let contents = @lib.read_file_from_path("inputs/day9-example.txt")
  match contents {
    Ok(contents) => inspect(solve(contents, 5), content="(127, 62)")
    Err(e) => println(e)
  }
}

///|
test "day 9" {
  let contents = @lib.read_file_from_path("inputs/day9.txt")
  match contents {
    Ok(contents) => inspect(solve(contents, 25), content="(85848519, 13414198)")
    Err(e) => println(e)
  }
}
