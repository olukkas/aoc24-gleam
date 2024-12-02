import gleam/option.{type Option, Some, None}
import gleam/int
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

pub fn parse_int(str: String) -> Int {
  let assert Ok(num) = int.parse(str)
  num
}

pub fn at(list: List(a), index: Int) -> Option(a) {
  case list, index {
    _, i if i < 0 -> None
    [], _ -> None
    [x, ..], 0 -> Some(x)
    [_, ..rest], i -> at(rest, i - 1)
  }
}