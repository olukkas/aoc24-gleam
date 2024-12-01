import day_1
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const example_input = ["3   4", "4   3", "2   5", "1   3", "3   9", "3   3"]

// gleeunit test functions end in `_test`
pub fn part1_test() {
  example_input
  |> day_1.part_1()
  |> should.equal(11)
}

pub fn part2_test() {
  example_input
  |> day_1.part_2()
  |> should.equal(31)
}
