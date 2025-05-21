///|
/// Read file from path relative to current directory
pub fn read_file_from_path(path : String) -> Result[@string.View, String] {
  let dir_option = @env.current_dir()
  match dir_option {
    Some(dir) => {
      let file = @fs.read_file_to_string?("\{dir}/\{path}")
      match file {
        Ok(contents) => Ok(@string.trim_space(contents))
        Err(e) => Err("Failed to read file: \{e}")
      }
    }
    None => Err("Could not get current directory")
  }
}
