import day_4
import gleam/string
import gleeunit/should

const input1 = "
..X...
.SAMX.
.A..A.
XMAS.S
.X....
"

const input2 = "
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"

pub fn part_1_test() {
  input1
  |> string.trim()
  |> day_4.part_1()
  |> should.equal(4)

  input2
  |> string.trim()
  |> day_4.part_1()
  |> should.equal(18)
}

pub fn count_xmas_test() {
  let input = "XMAS...SAMXMAS.."

  input
  |> day_4.count_word()
  |> should.equal(3)
}
