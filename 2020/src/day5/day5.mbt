///|
fn get_seat_id(str : @string.View) -> Int {
  let chars = str.to_string().to_array()
  let mut low_row = 0
  let mut high_row = 127
  let mut low_col = 0
  let mut high_col = 7
  for char in chars {
    let midpoint_row = (high_row - low_row) / 2
    let midpoint_col = (high_col - low_col) / 2
    match char {
      'F' =>
        high_row = if high_row - midpoint_row > low_row {
          high_row - midpoint_row - 1
        } else {
          high_row
        }
      'B' =>
        low_row = if low_row + midpoint_row < high_row {
          low_row + midpoint_row + 1
        } else {
          low_row
        }
      'L' =>
        high_col = if high_col - midpoint_col > low_col {
          high_col - midpoint_col - 1
        } else {
          high_col
        }
      'R' =>
        low_col = if low_col + midpoint_col < high_col {
          low_col + midpoint_col + 1
        } else {
          low_col
        }
      _ => ()
    }
  }
  low_row * 8 + low_col
}

///|
test "get_seat_id" {
  inspect(get_seat_id("FBFBBFFRLR"), content="357")
  inspect(get_seat_id("BFFFBBFRRR"), content="567")
  inspect(get_seat_id("FFFBBBFRRR"), content="119")
  inspect(get_seat_id("BBFFBBFRLL"), content="820")
}

///|
fn part1(ids : Array[Int]) -> Int {
  ids[ids.length() - 1]
}

///|
fn part2(ids : Array[Int]) -> Int {
  let mut my_id : Int? = None
  for i = 0; i < ids.length(); i = i + 1 {
    if ids[i + 1] != ids[i] + 1 {
      my_id = Some(ids[i] + 1)
      break
    }
  }
  match my_id {
    Some(id) => id
    None => -1
  }
}

///|
fn solve(input : @string.View) -> (Int, Int) {
  let ids = input.split("\n").to_array().map(get_seat_id)
  ids.sort()
  (part1(ids), part2(ids))
}

///|
test "day 5" {
  let contents = @lib.read_file_from_path("inputs/day5.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(970, 587)")
    Err(e) => println(e)
  }
}
