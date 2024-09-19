import gleeunit
import gleeunit/should
import part1

pub fn is_nice_string_test() {
  part1.is_nice_string("ugknbfddgicrmopn") |> should.equal(True)
  part1.is_nice_string("aaa") |> should.equal(True)
  part1.is_nice_string("jchzalrnumimnmhp") |> should.equal(False)
  part1.is_nice_string("haegwjzuvuyypxyu") |> should.equal(False)
  part1.is_nice_string("dvszwmarrgswjxmb") |> should.equal(False)
}

pub fn main() {
  gleeunit.main()
}
