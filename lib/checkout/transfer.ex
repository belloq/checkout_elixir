defmodule Checkout.Transfer do
  @moduledoc """

  Transfer funds while managing the entities to transfer money to recoup funds from a seller, return money from a refund or to make up the difference when running a promotion.

  Checkout API reference: https://api-reference.checkout.com/#tag/Transfers
  """

  @endpoint "transfers"

  @type source :: %{
          id: String.t(),
          amount: integer(),
          currency: String.t(),
          entity_id: String.t()
        }

  @type destination :: %{
          id: String.t(),
          entity_id: String.t()
        }

  @type create_params :: %{
          transfer_type: String.t(),
          source: source(),
          destination: %{required(:id) => String.t()},
          reference: String.t()
        }

  @type t :: %__MODULE__{
          id: String.t(),
          status: String.t(),
          reference: String.t(),
          requested_on: DateTime.t(),
          reason_codes: list(String.t()),
          source: source(),
          destination: destination()
        }

  defstruct [
    :id,
    :status,
    :reference,
    :requested_on,
    :reason_codes,
    :source,
    :destination
  ]

  @doc """
    Initiate a transfer of funds from source entity to destination entity.

    https://api-reference.checkout.com/#operation/createTransfer
  """
  @spec create(create_params(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def create(params, header_opts \\ []) do
    Checkout.make_request(:post, @endpoint, params, header_opts)
  end

  @doc """
    Retrieve transfer details using the transfer identifier.

    https://api-reference.checkout.com/#operation/getTransferDetails
  """
  @spec get(String.t(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def get(id, header_opts \\ []) do
    Checkout.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end
end
