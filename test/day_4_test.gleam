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

const input3 = "
M.S
.A.
M.S
"

const input4 = "
.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........
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

pub fn part_2_test() {
  input3
  |> string.trim()
  |> day_4.part_2()
  |> should.equal(1)

  input4
  |> string.trim()
  |> day_4.part_2()
  |> should.equal(9)
}
