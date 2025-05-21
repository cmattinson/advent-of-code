///|
fn get_count(grid : Array[Array[Char]], dx~ : Int = 3, dy~ : Int = 1) -> Int {
  let mut tree_count = 0
  let mut x = 0
  let mut y = 0
  while y < grid.length() {
    if grid[y][x] == '#' {
      tree_count += 1
    }
    x = if x + dx < grid[y].length() {
      x + dx
    } else {
      x + dx - grid[y].length()
    }
    y += dy
  }
  tree_count
}

///|
fn part1(grid : Array[Array[Char]]) -> Int {
  get_count(grid)
}

///|
fn part2(grid : Array[Array[Char]]) -> Int {
  let arr : Array[Int] = [
    get_count(grid, dx=1, dy=1),
    get_count(grid),
    get_count(grid, dx=5, dy=1),
    get_count(grid, dx=7, dy=1),
    get_count(grid, dx=1, dy=2),
  ]
  arr.fold(init=1, fn { a, b => a * b })
}

///|
fn solve(input : @string.View) -> (Int, Int) {
  let grid = input
    .split("\n")
    .map(fn { line => @string.to_array(line.to_string()) })
    .to_array()
  (part1(grid), part2(grid))
}

///|
test "day 3" {
  let contents = @lib.read_file_from_path("inputs/day3.txt")
  match contents {
    Ok(contents) => inspect!(solve(contents), content="(257, 1744787392)")
    Err(e) => println(e)
  }
}
