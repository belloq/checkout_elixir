defmodule Checkout.Card do
  @moduledoc """
  Checkout API reference: https://docs.checkout.com/reference/merchant-api-reference/cards/create-card
  """

  defp endpoint(customer_id) do
    "/customers/#{customer_id}/cards"
  end

  @doc """
  Return a list of Cards for given Customer ID.

  ## Example
  ```
    Checkout.Card.list("cust_UUID")
  ```
  """
  def list(customer_id) do
    Checkout.make_request(:get, endpoint(customer_id))
  end


  @doc """
  Retrieve a given Card with the specified ID.

  ## Example
  ```
    Checkout.Card.get("cust_UUID", "card_UUID")
  ```
  """
  def get(customer_id, id) do
    Checkout.make_request(:get, "#{endpoint(customer_id)}/#{id}")
  end

  @doc """
  Create a Card with the given card token.

  ## Example
  ```
    Checkout.Card.create("cust_UUID", "card_tok_UUID")
  ```
  """
  def create(customer_id, token) do
    Checkout.make_request(:post, endpoint(customer_id), %{token: token})
  end

  @doc """
  Update a Card with the given parameters.

  ## Example
  ```
    Checkout.Card.create("cust_UUID", "card_UUID", %{name: "Test User"})
  ```
  """
  def update(customer_id, id, params) do
    Checkout.make_request(:put, "#{endpoint(customer_id)}/#{id}", params)
  end

  @doc """
  Delete a Card with the specified ID.

  ## Example
  ```
    Checkout.Card.delete("cust_UUID", "card_UUID")
  ```
  """
  def delete(customer_id, id) do
    Checkout.make_request(:delete, "#{endpoint(customer_id)}/#{id}")
  end
end
