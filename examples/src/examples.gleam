import gleam/int
import gond.{cond, fact, run, when, yield}

fn example() {
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
  echo example()
}
