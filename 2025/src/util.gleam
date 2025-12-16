import gleam/option.{type Option, None, Some}
import gleam/string
import simplifile

pub fn read_file(file: String) -> Option(String) {
  case simplifile.read(file) {
    Ok(file) -> Some(string.trim(file))
    Error(_) -> None
  }
}

pub fn read_lines_untrimmed(file: String) -> Option(List(String)) {
  case simplifile.read(file) {
    Ok(file) -> Some(string.split(file, "\n"))
    Error(_) -> None
  }
}

pub fn read_lines(file: String) -> Option(List(String)) {
  case simplifile.read(file) {
    Ok(file) -> Some(string.split(string.trim(file), "\n"))
    Error(_) -> None
  }
}
