defmodule Checkout.Token do
  @endpoint "tokens"
  @doc """
  Create a Payment Token with the given payment data.

  Checkout API reference: https://api-reference.checkout.com/#tag/Tokens

  ## Example
  ```
  Checkout.Token.create(%{
    type: "applepay",
    token_data: %{
      version: "EC_v1",
      data: "t7GeajLB9skXB...EE2QE=",
      signature: "MIAGCSq...f0AAAAAAAA=",
      header: %{
        ephemeralPublicKey: "MFkwEwY...r3K/zlsw==",
        publicKeyHash: "tqYV+t...gEz6Nl0=",
        transactionId: "3cee896791...d17b4"
      }
    })
  ```
  """
  def create(params, header_opts \\ []) do
    header_opts = Keyword.merge(header_opts, [public: true])
    Checkout.make_request(:post, @endpoint, params, header_opts)
  end
end
