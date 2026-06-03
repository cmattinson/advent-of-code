///|
fn solve(_input : @string.View) -> (Int, Int) {
  (0, 0)
}

///|
test "day _ example" {
  let contents = @lib.read_file_from_path("inputs/day_-example.txt")
  match contents {
    Ok(contents) => inspect(solve(contents), content="(0,0)")
    Err(e) => println(e)
  }
}
