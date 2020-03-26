defmodule Checkout.Charge do
  @moduledoc """
  Checkout API reference: https://archive.docs.checkout.com/docs/capture_a_payment
  """

  @endpoint "charges"

  @doc """
  Create a Charge with Card ID.

  ## Example
  ```
    Checkout.Charge.create(%{
      cardId: "card_UUID",
      email: "test@example.org",
      value: 100,
      currency: "USD"
    })
  ```
  """
  def create(%{cardId: card_id} = params) when not is_nil(card_id) do
    Checkout.make_request(:post, "#{@endpoint}/card", params)
  end

  @doc """
  Create a Charge with Card Token.

  ## Example
  ```
    Checkout.Charge.create(%{
      cardToken: "card_tok_UUID",
      email: "test@example.org",
      value: 100,
      currency: "USD"
    })
  ```
  """
  def create(%{cardToken: card_token} = params) when not is_nil(card_token) do
    Checkout.make_request(:post, "#{@endpoint}/token", params)
  end

  @doc """
  Create a Charge with Full Card.

  ## Example
  ```
    Checkout.Charge.create(%{
      email: "test@example.org",
      value: 100,
      currency: "USD",
      card: %{
        number: "4242424242424242",
        expiryMonth: 6,
        expiryYear: 2018,
        cvv: 100
      }
    })
  ```
  """
  def create(%{card: card} = params) when is_map(card) do
    Checkout.make_request(:post, "#{@endpoint}/card", params)
  end

  @doc """
  Create a Charge with Default card.

  ## Example
  ```
    Checkout.Charge.create(%{
      email: "test@example.org",
      value: 100,
      currency: "USD"
    })
  ```
  """
  def create(params) do
    Checkout.make_request(:post, "#{@endpoint}/customer", params)
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
  Update a Charge with the given parameters.

  ## Example
  ```
    Checkout.Charge.update("charge_ID", %{description: "charge updated"})
  ```
  """
  def update(id, params) do
    Checkout.make_request(:put, "#{@endpoint}/#{id}", params)
  end

  @doc """
  Capture a Charge with the specified Charge ID.

  ## Example
  ```
    Checkout.Charge.capture("charge_ID")
  ```
  """
  def capture(id) do
    Checkout.make_request(:post, "#{@endpoint}/#{id}/capture")
  end

  @doc """
  Void a Charge with the specified Charge ID.

  ## Example
  ```
    Checkout.Charge.void("charge_ID")
  ```
  """
  def void(id) do
    Checkout.make_request(:post, "#{@endpoint}/#{id}/void")
  end

  @doc """
  Refund a Charge with the specified Charge ID.

  ## Example
  ```
    Checkout.Charge.refund("charge_ID")
  ```
  """
  def refund(id) do
    Checkout.make_request(:post, "#{@endpoint}/#{id}/refund")
  end

  @doc """
  Retrieve a given Charge History with the specified Charge ID.

  ## Example
  ```
    Checkout.Charge.history("charge_ID")
  ```
  """
  def history(id) do
    Checkout.make_request(:get, "#{@endpoint}/#{id}/history")
  end

  @doc """
  Create an Alternative Payment Charge

  ## Example
  ```
    Checkout.Charge.localpayment(%{
      email: "test@email.com",
      localPayment: %{
        lppId: "lpp_19",
        userData: %{}
      },
      paymentToken: "pay_tok_UUID"
    })
  ```
  """
  def localpayment(params) do
    Checkout.make_request(:post, "#{@endpoint}/localpayment", params)
  end
end
