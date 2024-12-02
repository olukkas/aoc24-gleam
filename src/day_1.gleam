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
  |> io.debug()

  lines
  |> part_2()
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
  let freqs = frequency(right)

  list.fold(left, 0, fn(total, current) {
    let occurences = dict.get(freqs, current) |> result.unwrap(0)
    total + { current * occurences }
  })
}

fn parse(lines: List(String)) -> #(List(Int), List(Int)) {
  let lines = list.map(lines, parse_line)
  use tuple, nums <- list.fold(lines, #([], []))

  let #(left, right) = tuple
  let assert [x, y] = nums

  #([x, ..left], [y, ..right])
}

fn parse_line(line: String) -> List(Int) {
  line
  |> string.split(on: "   ")
  |> list.map(utils.parse_int)
}

fn frequency(source: List(a)) -> Dict(a, Int) {
  list.fold(source, dict.new(), fn(map, key) {
    dict.upsert(map, key, fn(opt) { option.unwrap(opt, 0) + 1 })
  })
}
