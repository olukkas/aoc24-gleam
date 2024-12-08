import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import simplifile

pub fn read_input_file(name: String) -> String {
  let assert Ok(cwd) = simplifile.current_directory()
  let assert Ok(content) = simplifile.read(cwd <> "/src/inputs/" <> name)

  content
}

pub fn lines(content: String) -> List(String) {
  content
  |> string.split(on: "\n")
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

pub fn head(list: List(a)) -> a {
  let assert Ok(h) = list.first(list)
  h
}

pub fn tail(list: List(a)) -> List(a) {
  let assert Ok(t) = list.rest(list)
  t
}

pub fn zip_with(l1: List(a), l2: List(b), f: fn(a, b) -> c) -> List(c) {
  do_zip_with(l1, l2, f, [])
}

fn do_zip_with(
  list1: List(a),
  list2: List(b),
  f: fn(a, b) -> c,
  acc: List(c),
) -> List(c) {
  case list1, list2 {
    [], _ -> acc
    _, [] -> acc
    [x, ..xs], [y, ..ys] -> do_zip_with(xs, ys, f, [f(x, y), ..acc])
  }
}
