import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp.{Match}
import utils.{parse_int}

// TODO: try to solve it without using regex

const regex_expr = "(?:mul\\((\\d+),\\s*(\\d+)\\)|do\\(\\)|don't\\(\\))"

pub type Operation {
  Mul(Int, Int)
  Do
  Dont
}

pub fn main() {
  let input = utils.read_input_file("day_3.txt")

  input
  |> part_1()
  |> io.debug()

  input
  |> part_2()
  |> io.debug()
}

pub fn part_1(input: String) -> Int {
  input
  |> parse()
  |> calculate(True)
}

pub fn part_2(input: String) -> Int {
  input
  |> parse()
  |> calculate(False)
}

fn parse(input: String) -> List(Operation) {
  let assert Ok(reg) = regexp.from_string(regex_expr)

  reg
  |> regexp.scan(input)
  |> list.map(parse_match)
}

fn parse_match(match: regexp.Match) -> Operation {
  case match {
    Match(_, [Some(x), Some(y)]) -> Mul(parse_int(x), parse_int(y))
    Match("do()", []) -> Do
    Match("don't()", []) -> Dont
    _ -> panic as "unreachable"
  }
}

fn calculate(operations: List(Operation), is_part1: Bool) -> Int {
  operations
  |> do_calculate(True, is_part1, [])
  |> list.fold(0, fn(acc, curr) { acc + curr })
}

fn do_calculate(
  operations: List(Operation),
  enabled: Bool,
  is_part1: Bool,
  acc: List(Int),
) -> List(Int) {
  case operations {
    [] -> acc
    [Do, ..rest] -> do_calculate(rest, True, is_part1, acc)
    [Dont, ..rest] -> do_calculate(rest, False, is_part1, acc)
    [Mul(x, y), ..rest] if enabled || is_part1 -> {
      let mult = x * y
      do_calculate(rest, enabled, is_part1, [mult, ..acc])
    }
    [_, ..rest] -> do_calculate(rest, is_part1, enabled, acc)
  }
}
