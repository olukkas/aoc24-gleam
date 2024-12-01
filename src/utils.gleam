import gleam/list
import gleam/string
import simplifile

pub fn read_input_file(name: String) -> String {
  let assert Ok(cwd) = simplifile.current_directory()
  let assert Ok(content) = simplifile.read(cwd <> "/src/inputs/" <> name)

  content
}

pub fn lines(content: String) -> List(String) {
  content
  |> string.split(on: "\r\n")
  |> list.map(string.trim)
}
