defmodule Checkout.Payment do
  @moduledoc """
  Checkout API reference: https://api-reference.checkout.com/#tag/Payments
  """

  @endpoint "payments"

  @doc """
  Create a Payment with Card ID.

  ## Example
  ```
  Checkout.Payment.create(%{
    source: %{
      type: "id",
      id: "src_en2w67spfevehol7rh6m5zokeq",
      cvv: "100",
    },
    amount: 6500,
    currency: "USD",
  })
  ```
  Create a Payment with Card Token.

  ## Example
  ```
  Checkout.Payment.create(%{
    source: %{
      type: "token",
      token: "tok_wpzi5ph5r34uxfgvmxda67myva"
    },
    amount: 100,
    currency: "USD",
  })
  ```
  Create a Payment with Full Card.

  ## Example
  ```
  Checkout.Payment.create(%{
    amount: 100,
    currency: "USD",
    source: %{
      type: "card",
      number: "4242424242424242",
      expiry_month: "08",
      expiry_year: "2022",
      cvv: 100
    }
  })
  ```
  Create a Payment with Default card.

  ## Example
  ```
  Checkout.Payment.create(%{
    source: %{
      type: "customer",
      email: "test@example.org"
    },
    currency: "USD",
    amount: 100
  })
  ```
  """
  def create(params) do
    Checkout.make_request(:post, @endpoint, params)
  end
end
