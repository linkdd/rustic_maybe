# Rustic Maybe

[![CICD](https://github.com/linkdd/rustic_maybe/actions/workflows/test-suite.yml/badge.svg)](https://github.com/linkdd/rustic_maybe)
[![Hex.pm](http://img.shields.io/hexpm/v/rustic_maybe.svg?style=flat)](https://hex.pm/packages/rustic_maybe)
[![License](https://img.shields.io/hexpm/l/rustic_maybe)](https://github.com/linkdd/rustic_maybe/blob/main/LICENSE.txt)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/rustic_maybe/)

Maybe monad for Elixir inspired by Rust
[Option](https://doc.rust-lang.org/std/option/) type.

## Installation

This package can be installed by adding `rustic_maybe` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rustic_maybe, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
import Rustic.Maybe

some(1) == {:some, 1}
# true

nothing() == :nothing
# true

some(1) |> unwrap!()
# 1

nothing() |> unwrap!()
# ** (ArgumentError) trying to unwrap an empty Maybe monad

some(1) |> map(fn n -> n + 1 end)
# some(2)

nothing() |> map(fn n -> n + 1 end)
# nothing()

some(1) |> and_then(fn n -> some(n + 1) end)
# some(2)

nothing() |> and_then(fn n -> some(n + 1) end)
# nothing()

some(1) |> or_else(fn -> some(2) end)
# some(1)

nothing() |> or_else(fn -> some(2) end)
# some(2)

some(1) |> filter(fn n -> n > 0 end)
# some(1)

some(-1) |> filter(fn n -> n > 0 end)
# nothing()

nothing() |> filter(fn n -> n > 0 end)
# nothing()
```

For more examples, please consult the
[API reference](https://hexdocs.pm/rustic_maybe/Rustic.Maybe.html#content).


With function guards:

```elixir
import Rustic.Maybe

def handle_option(val) when is_nothing(val) do
  # ...
end
def handle_option(val) when is_some(val) do
  # ...
end
def handle_result(val) do
  raise ArgumentError, message: "#{inspect(val)} is not a Maybe monad"
end
```

## Usage with Rustic.Result

[Rustic.Result](https://github.com/rustic_result) is an implementation of the
Result monad, inspired by Rust's Result type.

**Result.Maybe** does not depend on **Rustic.Result** but can still work with
its data type:

```elixir
alias Rustic.Result  # if you installed it
alias Rustic.Maybe

Maybe.some(1) |> Maybe.ok_or(:no_value) == Result.ok(1)
# true

Maybe.nothing() |> Maybe.ok_or(:no_value) == Result.err(:no_value)
# true

Maybe.some(Result.ok(1)) |> Maybe.transpose() == Result.ok(Maybe.some(1))
# true

Maybe.some(Result.err(:no_value)) |> Maybe.transpose() == Result.err(:no_value)
# true

Maybe.nothing() |> Maybe.transpose() == Result.ok(Maybe.nothing())
# true
```

For more examples, please consult the
[API reference](https://hexdocs.pm/rustic_maybe/Rustic.Maybe.html#content).
