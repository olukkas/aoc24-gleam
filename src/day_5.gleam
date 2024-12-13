import gleam/dict
import gleam/io
import gleam/list.{length}
import gleam/option.{None, Some}
import gleam/pair
import gleam/result
import gleam/string
import utils.{parse_int}

pub type Rules =
  dict.Dict(Int, List(Int))

pub type RuleSet {
  RuleSet(rules: Rules, updates: List(List(Int)))
}

pub fn main() {
  let content = utils.read_input_file("day_5.txt")

  content
  |> part_1()
  |> io.debug()

  content
  |> part_2()
  |> io.debug()
}

pub fn part_1(input: String) -> Int {
  let #(rules, updates) = parse(input)

  updates
  |> list.filter(is_update_valid(rules, _))
  |> list.map(get_mids)
  |> utils.sum()
}

pub fn part_2(input: String) -> Int {
  let #(rules, updates) = parse(input)
  let #(_, unoredered) = list.partition(updates, is_update_valid(rules, _))

  unoredered
  |> list.map(sort_unordered(rules, _))
  |> list.map(list.reverse)
  |> list.map(get_mids)
  |> utils.sum()
}

fn parse(input) {
  let #(rules, updates) =
    string.split(input, "\n")
    |> list.partition(string.contains(_, "|"))
    |> pair.map_first(list.map(_, string.trim_end))
    |> pair.map_second(list.map(_, string.trim_end))

  let relations = parse_rules(rules |> list.filter(fn(x) { x != "" }))
  let updates = parse_updates(updates |> list.filter(fn(x) { x != "" }))

  #(relations, updates)
}

fn parse_rules(rules) {
  let rules_pages =
    list.map(rules, fn(rule) {
      let assert Ok(#(before, after)) = string.split_once(rule, "|")
      #(parse_int(before), parse_int(after))
    })

  list.fold(rules_pages, dict.new(), fn(set, pages) {
    let #(before, after) = pages
    dict.upsert(set, before, fn(opt) {
      case opt {
        Some(xs) -> [after, ..xs]
        None -> [after]
      }
    })
  })
}

fn parse_updates(updates) {
  updates
  |> list.map(string.split(_, ","))
  |> list.map(list.map(_, parse_int))
}

fn is_update_valid(rules: Rules, updates: List(Int)) -> Bool {
  case updates {
    [] | [_] -> True
    [first, ..rest] -> {
      let is_before =
        list.all(rest, fn(key) {
          rules
          |> dict.get(first)
          |> result.map(list.contains(_, key))
          |> result.unwrap(False)
        })

      is_before && is_update_valid(rules, rest)
    }
  }
}

fn get_mids(list: List(Int)) -> Int {
  let mid_index = length(list) / 2
  utils.at(list, mid_index) |> option.unwrap(0)
}

fn sort_unordered(rules: Rules, pages: List(Int)) {
  case pages {
    [] -> []
    [x] -> [x]
    [first, ..rest] -> {
      let befores =
        rules
        |> dict.get(first)
        |> result.unwrap([])
        |> list.filter(list.contains(pages, _))

      let afters =
        rest
        |> list.filter(fn(num) { !list.contains(befores, num) })

      list.flatten([
        sort_unordered(rules, befores),
        [first],
        sort_unordered(rules, afters),
      ])
    }
  }
}
