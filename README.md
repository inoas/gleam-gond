# 🚡 Gond 🚠

[![Package <a href="https://github.com/inoas/gleam-gond/releases"><img src="https://img.shields.io/github/release/inoas/gleam-gond" alt="GitHub release"></a> Version](https://img.shields.io/hexpm/v/gond)](https://hex.pm/packages/gond)
[![Erlang-compatible](https://img.shields.io/badge/target-erlang-b83998)](https://www.erlang.org/)
[![JavaScript Compatible](https://img.shields.io/badge/target-javascript-f3e155)](https://en.wikipedia.org/wiki/JavaScript)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gond/)
[![Discord](https://img.shields.io/discord/768594524158427167?label=discord%20chat&amp;color=5865F2)](https://discord.gg/Fm8Pwmy)
[![CI Test](https://github.com/inoas/gleam-gond/actions/workflows/test.yml/badge.svg?branch=main&amp;event=push)](https://github.com/inoas/gleam-gond/actions/workflows/test.yml)

Multi-branch conditional expression similar to `if`-`else if`-`else` or `cond` for Gleam.

<i>
  Think of a <a href="https://en.wikipedia.org/wiki/Gondola_lift">gondola lift </a> ride,
  where you can hop off at any station.
</i>

<br>

## Installation

```sh
gleam add gond@2
```

## Examples

```gleam
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

## Inspirations

- Clojure's [`cond` macro](https://clojuredocs.org/clojure.core/cond).
- Elixir's [`cond` macro](https://hexdocs.pm/elixir/case-cond-and-if.html#cond).

## Tags

- `elseif`
- `elif`
- `if statement`
