import gleam/list
import gleam/string

fn vowel_count(str) {
  str
  |> string.to_graphemes
  |> list.fold(0, fn(accum, grapheme) {
    case grapheme {
      "a" | "e" | "i" | "o" | "u" -> accum + 1
      _ -> accum
    }
  })
}

fn has_consecutive_letter(str) {
  str
  |> string.to_graphemes
  |> list.window_by_2
  |> list.any(fn(window) { window.0 == window.1 })
}

fn has_invalid_substring(str) {
  string.contains(str, "ab")
  || string.contains(str, "cd")
  || string.contains(str, "pq")
  || string.contains(str, "xy")
}

pub fn is_nice_string(str) {
  vowel_count(str) >= 3
  && has_consecutive_letter(str)
  && !has_invalid_substring(str)
}
