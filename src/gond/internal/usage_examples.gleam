import gleam/int
import gleam/io
import gleam/string
import gond.{
  cond as cond, fact as fact, run as run, when as when, yield as yield,
}

pub fn example() {
  cond(
    branches: [
      when(fn() { int.random(3) == 1 }) |> run(fn() { "Heads!" }),
      fact(int.random(3) == 2) |> run(fn() { "Tails!" }),
      when(fn() { True }) |> yield("This always occurs!"),
      fact(False) |> yield("This is never the fact!"),
    ],
    default: fn() { "Lost the coin?" },
  )
}

pub fn main() {
  example() |> string.inspect |> io.println
}
