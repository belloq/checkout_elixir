defmodule Checkout.Customer do
  @moduledoc """
  Checkout API reference: https://api-reference.checkout.com/#tag/Customers
  """

  @endpoint "customers"

  @type phone :: %{
          country_code: String.t(),
          number: String.t()
        }

  @type create_params :: %{
          required(:email) => String.t(),
          optional(:name) => String.t(),
          optional(:phone) => phone,
          optional(:metadata) => map(),
          optional(:default) => String.t(),
          optional(:instruments) => list(String.t())
        }

  @type t :: %__MODULE__{
          id: String.t(),
          email: String.t(),
          name: String.t(),
          phone: phone,
          metadata: map(),
          default: String.t(),
          instruments: list(String.t())
        }

  defstruct [
    :id,
    :email,
    :name,
    :phone,
    :metadata,
    :default,
    :instruments
  ]

  @doc """
    Store a customer's details in a customer object to reuse in future payments.
    When creating a customer, you can link payment instruments – the customer id returned can be passed as a source when making a payment.

    https://api-reference.checkout.com/#operation/createCustomer
  """
  @spec create(create_params(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def create(params, header_opts \\ []) do
    Checkout.make_request(:post, @endpoint, params, header_opts)
  end

  @doc """
    Returns the details of a customer and their payment instruments.

    https://api-reference.checkout.com/#operation/getCustomerDetails
  """
  @spec get(String.t(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def get(id, header_opts \\ []) do
    Checkout.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end
end
