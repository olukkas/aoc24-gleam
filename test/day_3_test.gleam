import day_3
import gleeunit/should

const input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

const input2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5)"

pub fn part_1_test() {
  input
  |> day_3.part_1()
  |> should.equal(161)
}

pub fn part_2_test() {
  input2
  |> day_3.part_2()
  |> should.equal(48)
}
