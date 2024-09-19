import gleam/list
import gleam/string

fn build_string(chars) {
  chars |> list.fold("", fn(accum, char) { accum <> char })
}

pub fn find_pairs(str) {
  let chars = str |> string.to_graphemes

  case chars {
    [] -> False
    [_] -> False
    [_, _] -> False
    [a, b, ..rest] -> {
      case string.contains(does: build_string(rest), contain: a <> b) {
        True -> True
        False -> find_pairs(build_string([b, ..rest]))
      }
    }
  }
}

pub fn has_letter_sandwich(str) {
  str
  |> string.to_graphemes
  |> list.window(3)
  |> list.any(fn(window) {
    case window {
      [a, _, c] if a == c -> True
      _ -> False
    }
  })
}

pub fn is_nice_string(str) {
  { str |> find_pairs } && has_letter_sandwich(str)
}
