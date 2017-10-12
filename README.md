# Checkout for Elixir

A [Checkout.com](https://checkout.com) library for Elixir.

[Documentation](http://hexdocs.pm/checkout_elixir)

## Installation

Add `checkout_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:checkout_elixir, "~> 1.0.0"}
  ]
end
```

## Configuration

To make API calls, it's necessary to configure your Checkout.com keys.

Add to your config:
```elixir
config :checkout_elixir,
  secret_key: "sk_UUID",
  public_key: "pk_UUID"
```
or add to your environment:
```bash
export CHECKOUT_SECRET_KEY=sk_UUID
export CHECKOUT_PUBLIC_KEY=pk_UUID
```

If you want to use it in sandbox mode:
```elixir
config :checkout_elixir, sandbox: true
```
