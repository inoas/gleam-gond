# Gond 🔠 · `cond` for Gleam

[![Package <a href="https://github.com/inoas/gleam-gond/releases"><img src="https://img.shields.io/github/release/inoas/gleam-gond" alt="GitHub release"></a> Version](https://img.shields.io/hexpm/v/gond)](https://hex.pm/packages/gond)
[![Erlang-compatible](https://img.shields.io/badge/target-erlang-b83998)](https://www.erlang.org/)
[![JavaScript Compatible](https://img.shields.io/badge/target-javascript-f3e155)](https://en.wikipedia.org/wiki/JavaScript)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gond/)
[![Discord](https://img.shields.io/discord/768594524158427167?label=discord%20chat&amp;color=5865F2)](https://discord.gg/Fm8Pwmy)
[![CI Test](https://github.com/inoas/gleam-gond/actions/workflows/test.yml/badge.svg?branch=main&amp;event=push)](https://github.com/inoas/gleam-gond/actions/workflows/test.yml)
```sh
gleam add gond@1
```

## Examples

```gleam
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

```

```shell
gleam run --module gond/internal/usage_examples
```

Further documentation can be found at <https://hexdocs.pm/gond>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```

## Inspiration

Elixir's [`cond` macro](https://hexdocs.pm/elixir/case-cond-and-if.html#cond).
