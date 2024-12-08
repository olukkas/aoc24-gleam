import gleam/io
import gleam/list.{length}
import gleam/option
import gleam/string
import utils

pub fn main() {
  let content = utils.read_input_file("day_4.txt")

  content
  |> part_1()
  |> io.debug()
}

pub fn part_1(input: String) {
  let grid = utils.lines(input)
  count_word_grid(grid)
}

fn get_diagonals(grid: List(String)) -> List(String) {
  let len = length(grid)
  let range = list.range(-len, len)

  list.map(range, get_diagonal(grid, _)) 
}

fn get_diagonal(grid: List(String), index: Int) -> String {
  let len = length(grid)
  let range = list.range(index, len * 2)

  let diagonal = {
    use row, i <- utils.zip_with(grid, range)
    let row = string.to_graphemes(row)

    case i >= 0 && i < list.length(row) {
      True -> utils.at(row, i) |> option.unwrap(".")
      False -> "."
    }
  }

  diagonal
  |> list.reverse()
  |> string.concat
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