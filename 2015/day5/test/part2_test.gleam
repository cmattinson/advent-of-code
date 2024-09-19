import gleeunit
import gleeunit/should
import part2

pub fn has_double_pairs_test() {
  "xyxy" |> part2.find_pairs |> should.equal(True)
  "aabcdefgaa" |> part2.find_pairs |> should.equal(True)
  "aaa" |> part2.find_pairs |> should.equal(False)
}

pub fn has_letter_sandwich_test() {
  "qjhvhtzxzqqjkmpb" |> part2.has_letter_sandwich |> should.equal(True)
  "xyx" |> part2.has_letter_sandwich |> should.equal(True)
  "abcdefeghi" |> part2.has_letter_sandwich |> should.equal(True)
}

pub fn main() {
  gleeunit.main()
}
