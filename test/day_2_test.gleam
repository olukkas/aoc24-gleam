import day_2
import gleeunit/should

const example_input = [
  "7 6 4 2 1", "1 2 7 8 9", "9 7 6 2 1", "1 3 2 4 5", "8 6 4 4 1", "1 3 6 7 9",
]

pub fn part1_test() {
  example_input
  |> day_2.part_1()
  |> should.equal(2)
}

pub fn part2_test() {
  example_input
  |> day_2.part_2()
  |> should.equal(4)
}
