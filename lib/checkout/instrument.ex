defmodule Checkout.Instrument do
  @moduledoc """
  Checkout API reference: https://api-reference.checkout.com/#tag/Instruments
  """

  alias Checkout.Customer

  @endpoint "instruments"

  @type create_params :: %{
          required(:type) => String.t(),
          required(:token) => String.t(),
          optional(:customer) => Customer.t()
        }

  @type t :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          fingerprint: String.t(),
          customer: Customer.t(),
          expiry_month: String.t(),
          expiry_year: String.t(),
          last4: String.t(),
          bin: String.t(),
          card_type: String.t(),
          card_category: String.t(),
          issuer: String.t(),
          issuer_country: String.t(),
          product_id: String.t(),
          product_type: String.t()
        }

  defstruct [
    :id,
    :type,
    :fingerprint,
    :customer,
    :expiry_month,
    :expiry_year,
    :last4,
    :bin,
    :card_type,
    :card_category,
    :issuer,
    :issuer_country,
    :product_id,
    :product_type
  ]

  @doc """
    Store a customer's details in a customer object to reuse in future payments.
    When creating a customer, you can link payment instruments – the customer id returned can be passed as a source when making a payment.

    https://api-reference.checkout.com/#operation/createAnInstrument
  """
  @spec create(create_params(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def create(params, header_opts \\ []) do
    Checkout.make_request(:post, @endpoint, params, header_opts)
  end

  @doc """
    Retrieve the details of a payment instrument.

    https://api-reference.checkout.com/#operation/getInstrumentDetails
  """
  @spec get(String.t(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def get(id, header_opts \\ []) do
    Checkout.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end
end
