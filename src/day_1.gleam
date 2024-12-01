import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/result
import gleam/string
import utils

pub fn main() {
  let lines =
    "day_1.txt"
    |> utils.read_input_file()
    |> utils.lines()

  lines
  |> part_1()
  |> string.inspect()
  |> string.append("Part1: ", _)
  |> io.debug()

  lines
  |> part_2()
  |> string.inspect()
  |> string.append("Part2: ", _)
  |> io.debug()
}

pub fn part_1(lines: List(String)) {
  let #(left, right) = parse(lines)

  let left = list.sort(left, by: int.compare)
  let right = list.sort(right, by: int.compare)

  let zipped = list.zip(left, right)
  use total, tuple <- list.fold(zipped, 0)

  let #(left_num, right_num) = tuple
  total + int.absolute_value(left_num - right_num)
}

pub fn part_2(lines: List(String)) -> Int {
  let #(left, right) = parse(lines)
  use total, current <- list.fold(left, 0)

  let occurences = get_frequency(right, current)
  total + { current * occurences }
}

fn parse(lines: List(String)) -> #(List(Int), List(Int)) {
  let lines = list.map(lines, parse_line)
  use tuple, nums <- list.fold(lines, #([], []))

  let #(left, right) = tuple
  let assert [x, y] = nums

  #([x, ..left], [y, ..right])
}

fn parse_line(line: String) -> List(Int) {
  let assert [left, right] = string.split(line, on: "   ")
  let assert Ok(left) = int.parse(left)
  let assert Ok(right) = int.parse(right)

  [left, right]
}

fn get_frequency(source: List(a), elem: a) -> Int {
  do_frequencis(source, dict.new())
  |> dict.get(elem)
  |> result.unwrap(0)
}

fn do_frequencis(source: List(a), acc: Dict(a, Int)) -> Dict(a, Int) {
  case source {
    [] -> acc
    [key, ..rest] -> {
      let new_map = dict.upsert(acc, key, fn(x) { option.unwrap(x, 0) + 1 })

      do_frequencis(rest, new_map)
    }
  }
}
