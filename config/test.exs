import Config

config :checkout_elixir,
  sandbox: true

config :exvcr,
  filter_request_headers: ["Authorization"]
