defmodule Checkout.Customer do
  @moduledoc """
  Checkout API reference: https://archive.docs.checkout.com/docs/get-customer
  """

  @endpoint "customers"

  @doc """
  Return a list of Customers.

  ## Example
  ```
    Checkout.Customer.list(nil, nil, 1)
  ```
  """
  def list(from_date \\ nil, to_date \\ nil, count \\ nil, offset \\ nil) do
    params =
      []
      |> put_param(:fromDate, from_date)
      |> put_param(:toDate, to_date)
      |> put_param(:count, count)
      |> put_param(:offset, offset)

    Checkout.make_request(:get, @endpoint, nil, nil, [params: params])
  end

  @doc """
  Retrieve a given Customer with the specified ID or email.

  ## Example
  ```
    Checkout.Customer.get("cust_UUID")
  ```
  """
  def get(id_or_email) do
    if String.match?(id_or_email, ~r/@/) do
      Checkout.make_request(:get, @endpoint, nil, nil, [params: [{:email, id_or_email}]])
    else
      Checkout.make_request(:get, "#{@endpoint}/#{id_or_email}")
    end
  end

  @doc """
  Create a Customer with the given parameters.

  ## Example
  ```
    Checkout.Customer.create(%{email: "test@example.org"})
  ```
  """
  def create(params) do
    Checkout.make_request(:post, @endpoint, params)
  end

  @doc """
  Update a Customer with the given parameters.

  ## Example
  ```
    Checkout.Customer.update("cust_UUID", %{email: "test@example.org"})
  ```
  """
  def update(id, params) do
    Checkout.make_request(:put, "#{@endpoint}/#{id}", params)
  end

  @doc """
  Delete a Customer with the specified ID.

  ## Example
  ```
    Checkout.Customer.delete("cust_UUID")
  ```
  """
  def delete(id) do
    Checkout.make_request(:delete, "#{@endpoint}/#{id}")
  end

  defp put_param(params, key, value) do
    if is_nil(value) do
      params
    else
      Keyword.put(params, key, value)
    end
  end
end
