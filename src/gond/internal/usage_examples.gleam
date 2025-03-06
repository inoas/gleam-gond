import gleam/int
import gleam/io
import gleam/string
import gond.{
  cond as cond, return as return, run as run, when as when, where as where,
}

pub fn example() {
  cond(
    branches: [
      when(fn() { int.random(3) == 1 }) |> run(fn() { "Heads!" }),
      where(int.random(3) == 2) |> run(fn() { "Tails!" }),
      when(fn() { True }) |> return("This always when!"),
      where(False) |> return("This is never the fact!"),
    ],
    default: fn() { "Lost the coin?" },
  )
}

pub fn main() {
  example() |> string.inspect |> io.println
}
