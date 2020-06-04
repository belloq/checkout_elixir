defmodule Checkout.Charge do
  @moduledoc """
  Checkout API reference: https://archive.docs.checkout.com/docs/capture_a_payment
  """

  @endpoint "payments"

  @doc """
  Create a Charge with Card ID.

  ## Example
  ```
  Checkout.Charge.create(%{
    source: %{
      type: "id",
      id: "src_en2w67spfevehol7rh6m5zokeq",
      cvv: "100",
    },
    email: "test@example.org",
    amount: 6500,
    currency: "USD",
    reference: "ORD-5023-4E89"
  })
  ```
  Create a Payment with Card Token.

  ## Example
  ```
    Checkout.Charge.create(%{
      source: %{
        type: "token",
        token: "card_tok_9EDE49...A52CC25"
      },
      amount: 2000,
      currency: "USD",
      reference: "TRK12345"
    })
  ```
  Create a Charge with Full Card.

  ## Example
  ```
    Checkout.Charge.create(%{
      source: %{
        type: "card",
        number: "4242424242424242",
        expiry_month: 8,
        expiry_year: 2022,
        cvv: "100"
      },
      amount: 2000,
      currency: "USD",
      reference: "TRK12345"
    })
  ```
  Create a Charge with Default card.

  ## Example
  ```
    Checkout.Charge.create(%{
  	  source: %{
        type: "customer",
        id: "cus_dxbrk2ruktbutlnbtilhv2qyzm",
      },
      amount: 2000,
      currency:"USD",
      reference: "TRK12345"
    })
  ```
  """
  def create(params) do
    Checkout.make_request(:post, @endpoint, params)
  end

  @doc """
  Retrieve a given Charge with the specified Charge ID or Payment Token.

  ## Example
  ```
    Checkout.Charge.get("charge_ID")
  ```
  """
  def get(id) do
    Checkout.make_request(:get, "#{@endpoint}/#{id}")
  end

  @doc """
  Void a Charge with the specified Charge ID.

  ## Example
  ```
    Checkout.Charge.void("charge_ID")
  ```
  """
  def void(id) do
    Checkout.make_request(:post, "#{@endpoint}/#{id}/voids")
  end

  @doc """
  Refund a Charge with the specified Charge ID.

  ## Example
  ```
    Checkout.Charge.refund("charge_ID")
  ```
  """
  def refund(id) do
    Checkout.make_request(:post, "#{@endpoint}/#{id}/refunds")
  end

  @doc """
  Retrieve a given Charge History with the specified Charge ID.

  ## Example
  ```
    Checkout.Charge.history("charge_ID")
  ```
  """
  def history(id) do
    Checkout.make_request(:get, "#{@endpoint}/#{id}/actions")
  end
end
