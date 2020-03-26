defmodule Checkout.PaymentToken do
  @moduledoc """
  Checkout API reference: https://archive.docs.checkout.com/docs/create-a-payment-token
  """

  @endpoint "tokens/payment"

  @doc """
  Create a Payment Token with the given parameters.

  ## Example
  ```
    Checkout.PaymentToken.create(%{
      value: 100,
      currency: "USD",
      chargeMode: 3
    })
  ```
  """
  def create(params) do
    Checkout.make_request(:post, @endpoint, params)
  end

  @doc """
  Update a Card with the given parameters.

  ## Example
  ```
    Checkout.Card.update("pay_tok_UUID", %{trackId: "TRK12345"})
  ```
  """
  def update(id, params) do
    Checkout.make_request(:put, "#{@endpoint}/#{id}", params)
  end

  @doc """
  Create a Payment Token with the given Visa Checkout Call ID.

  Checkout API reference: https://archive.docs.checkout.com/docs/visa-checkout

  ## Example
  ```
    Checkout.PaymentToken.visa_checkout("6937148828912356701")
  ```
  """
  def visa_checkout(call_id, include_bin_data \\ false) do
    Checkout.make_request(:post, "tokens/card/visa-checkout", %{
      callId: call_id,
      includeBinData: include_bin_data
    }, false)
  end

  @doc """
  Create a Payment Token with the given payment data.

  Checkout API reference: https://archive.docs.checkout.com/docs/apple-pay

  ## Example
  ```
    Checkout.PaymentToken.apple_pay(%{
      version: "EC_v1",
      data: "J/a5u/KyFkXVy4ghO2../+tjRfzjylbX3djJDKPPIBAs=",
      signature: "MIAGCSqGSIb3DQEHAqCAMI..Ld2uMYqksJoO5lMlwAAAAAAAA==",
      header: %{
        applicationData: "BBQUHAgIwgbYMgbNS..ZWxpYW5jZSBvbiB0aGlzIGN==",
        ephemeralPublicKey: "MFkwEwYHKoZIzj0ZIzj0DAQcDQgAE..tf1z9S28unel+C+q7UXiuw==",
        wrappedKey: "3mWagrJNMIIC7jCCAnWgAwIBA..ISW0vvzqY2pcwCgYIKoZIzEAw",
        publicKeyHash: "tqYV+tmG9aMh+l/K6cic..1gUiLjSTM9gEz6Nl0=",
        transactionId: "11c21bd6357a0952f23817e..80b254c3a20734137cf7be168"
      }
    })
  ```
  """
  def apple_pay(params) do
    Checkout.make_request(:post, "applepay/token", params, false)
  end
end
