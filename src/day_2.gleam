import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils

pub fn main() {
  let lines =
    "day_2.txt"
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
  let nums = parse(lines)
  list.count(nums, is_safe)
}

pub fn part_2(_lines: List(String)) {
  Nil
}

fn parse(lines: List(String)) -> List(List(Int)) {
  list.map(lines, fn(line) {
    let digits = string.split(line, on: " ")
    list.map(digits, utils.parse_int)
  })
}

fn is_safe(list: List(Int)) -> Bool {
    let assert [x, y, ..] = list
    is_sorted(list, x > y) && check_diff(list)
}

fn is_sorted(list: List(Int), asc: Bool) -> Bool {
  case list, asc {
    [], _ -> True
    [_], _ -> True
    [x, y, ..rest], True -> {
        x > y && is_sorted([y, ..rest], True)
    }
    [x, y, ..rest], False -> {
        x < y && is_sorted([y, ..rest], False)
    }
  }
}

fn check_diff(list: List(Int)) -> Bool {
    case list {
        [] | [_]-> True
        [x, y, ..rest] -> {
            let differ = int.absolute_value(x - y)        
            {differ > 0 && differ < 4} && check_diff([y, ..rest])
        }
    }
}