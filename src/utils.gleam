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

/// Retorna `true` se a função fornecida retornar `true` para algum item e seu índice.
pub fn index_any(xs: List(a), f: fn(Int, a) -> Bool) -> Bool {
  do_index_any(xs, f, 0)
}

fn do_index_any(xs: List(a), f: fn(Int, a) -> Bool, index: Int) -> Bool {
  case xs {
    [] -> False
    [head, ..tail] ->
      case f(index, head) {
        True -> True
        False -> do_index_any(tail, f, index + 1)
      }
  }
}

/// Filtra a lista com base no índice e valor fornecidos para a função `f`.
pub fn index_filter(xs: List(a), f: fn(Int, a) -> Bool) -> List(a) {
  do_index_filter(xs, f, 0, [])
}

fn do_index_filter(
  xs: List(a),
  f: fn(Int, a) -> Bool,
  index: Int,
  acc: List(a),
) -> List(a) {
  case xs {
    [] -> list.reverse(acc)
    [head, ..tail] ->
      case f(index, head) {
        True -> do_index_filter(tail, f, index + 1, [head, ..acc])
        False -> do_index_filter(tail, f, index + 1, acc)
      }
  }
}
