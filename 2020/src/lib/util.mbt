///|
pub fn read_file_from_path(path : String) -> Result[@string.View, String] {
  let dir_option = @env.current_dir()
  match dir_option {
    Some(dir) => {
      let file = try? @fs.read_file_to_string("\{dir}/\{path}")
      match file {
        Ok(contents) => Ok(contents.trim_space())
        Err(e) => Err("Failed to read file: \{e}")
      }
    }
    None => Err("Could not get current directory")
  }
}

///|
pub fn read_lines_from_path(
  path : String,
) -> Result[Array[@string.View], String] {
  let dir_option = @env.current_dir()
  match dir_option {
    Some(dir) => {
      let file = try? @fs.read_file_to_string("\{dir}/\{path}")
      match file {
        Ok(contents) => Ok(contents.trim_space().split("\n").to_array())
        Err(e) => Err("Failed to read file: \{e}")
      }
    }
    None => Err("Could not get current directory")
  }
}
