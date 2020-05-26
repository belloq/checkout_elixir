defmodule Checkout.Charge do
  @moduledoc """
  Checkout API reference: https://archive.docs.checkout.com/docs/capture_a_payment
  """

  @endpoint "payments"

  def build_params(params, source) do
    params
    |> Map.put(:amount, Map.get(params, :value))
    |> Map.put(:source, source)
  end

  def payment_request(method, params, source) when method in [:post, :get] do
    Checkout.make_request(method, @endpoint, build_params(params, source))
  end

  @doc """
  Create a Charge with Card ID.

  ## Example
  ```
  Checkout.Payment.create(%{
    source: %{
      type: "id",
      id: "src_i3ywxkcgu5cevigmdxoy6km5je",
      cvv: "100",
    },
    amount: 6500,
    currency: "USD",
    reference: "ORD-5023-4E89"
  })
  ```
  """
  def create(%{cardId: card_id} = params) when not is_nil(card_id) do
    source = %{type: "id", id: card_id}

    payment_request(:post, params, source)
  end

  @doc """
  Create a Payment with Card Token.

  ## Example
  ```
    Checkout.Payment.create(%{
      source: %{
        type: "token",
        token: "card_tok_9EDE49...A52CC25"
      },
      amount: 2000,
      currency: "USD",
      reference: "TRK12345"
    })
  ```
  """
  def create(%{cardToken: card_token} = params) do
    source = %{
      type: "token",
      token: card_token
    }

    payment_request(:post, params, source)
  end

  @doc """
  Create a Charge with Full Card.

  ## Example
  ```
    Checkout.Charge.create(%{
      source: %{
        type:"card",
        number: "4242424242424242",
        expiry_month: 9,
        expiry_year: 2019,
        cvv: "100"
      },
      amount: 2000,
      currency:"USD",
      reference: "TRK12345"
    })
  ```
  """
  def create(%{card: card} = params) when is_map(card) do
    source = %{
      type: "card",
      number: Map.get(card, :number),
      expiry_month: Map.get(card, :expiryMonth),
      expiry_year: Map.get(card, :expiryYear),
      cvv: Map.get(card, :cvv)
    }

    payment_request(:post, params, source)
  end

  @doc """
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
    source = %{type: "customer"}

    payment_request(:post, params, source)
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
    Checkout.make_request(:post, "#{@endpoint}/#{id}/captures")
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
