import gleam/string
import simplifile

pub fn read_file(file: String) -> String {
  let assert Ok(file) = simplifile.read(file)
  string.trim(file)
}

pub fn read_lines(file: String) -> List(String) {
  let assert Ok(file) = simplifile.read(file)
  string.split(string.trim(file), "\n")
}

pub fn read_lines_raw(file: String) -> List(String) {
  let assert Ok(file) = simplifile.read(file)
  string.split(file, "\n")
}
