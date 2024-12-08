import gleam/io
import gleam/list.{length}
import gleam/option.{type Option, Some}
import gleam/string
import utils

pub fn main() {
  let content = utils.read_input_file("day_4.txt")

  content
  |> part_1()
  |> io.debug()

  content
  |> part_2()
  |> io.debug()
}

pub fn part_1(input: String) {
  let grid = utils.lines(input)
  count_word_grid(grid)
}

pub fn part_2(input: String) {
  let grid = utils.lines(input) |> list.map(string.to_graphemes)
  use total, row, x <- list.index_fold(grid, 0)

  let count = {
    use acc, char, y <- list.index_fold(row, 0)

    case char {
      "A" -> {
        case check_cross(grid, x, y) {
          True -> acc + 1
          False -> acc
        }
      }
      _ -> acc
    }
  }

  total + count
}

fn check_cross(grid: List(List(String)), x: Int, y: Int) -> Bool {
  let left_bottom = get_char(grid, x - 1, y - 1)
  let right_top = get_char(grid, x + 1, y + 1)

  let left_top = get_char(grid, x + 1, y - 1)
  let right_bottom = get_char(grid, x - 1, y + 1)

  check_cross_help(left_bottom, right_top)
  && check_cross_help(left_top, right_bottom)
}

fn check_cross_help(a: Option(String), b: Option(String)) -> Bool {
  case a, b {
    Some("M"), Some("S") | Some("S"), Some("M") -> True
    _, _ -> False
  }
}

fn get_char(grid: List(List(String)), x: Int, y: Int) -> Option(String) {
  grid
  |> utils.at(x)
  |> option.then(utils.at(_, y))
}

pub fn get_diagonals(grid: List(String)) -> List(String) {
  let len = length(grid)
  let range = list.range(-len, len)

  list.map(range, get_diagonal(grid, _))
}

fn get_diagonal(grid: List(String), index: Int) -> String {
  let diagonals = {
    use row, i <- list.index_map(grid)
    let chars = string.to_graphemes(row)
    let i = i + index

    case i >= 0 && i < length(chars) {
      True -> utils.at(chars, i) |> option.unwrap("")
      False -> "."
    }
  }
  string.concat(diagonals)
}

fn count_word_grid(grid: List(String)) {
  let transposed = transpose_grid(grid)
  let diagonals = get_diagonals(grid)
  let anti_diagonals = get_diagonals(grid |> list.map(string.reverse))

  [grid, transposed, diagonals, anti_diagonals]
  |> list.flatten()
  |> list.map(count_word)
  |> list.fold(0, fn(a, b) { a + b })
}

pub fn count_word(text: String) -> Int {
  let tail = string.drop_start(text, 1)
  case text {
    "" -> 0
    "XMAS" <> _rest -> 1 + count_word(tail)
    "SAMX" <> _rest -> 1 + count_word(tail)
    _ -> count_word(tail)
  }
}

fn transpose_grid(grid: List(String)) -> List(String) {
  grid
  |> list.map(string.to_graphemes)
  |> list.transpose()
  |> list.map(string.concat)
}
