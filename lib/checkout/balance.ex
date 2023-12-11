defmodule Checkout.Balance do
  @moduledoc """

  View balances for currency accounts belonging to an entity.

  Checkout API reference: https://api-reference.checkout.com/#tag/Balances
  """

  @endpoint "balances"

  @type balances :: %{
          available: integer(),
          collateral: integer(),
          payable: integer(),
          pending: integer()
        }

  @type account_balance :: %{
          currency_account_id: String.t(),
          descriptor: String.t(),
          holding_currency: String.t(),
          balances: balances()
        }

  @type t :: %__MODULE__{
          data: list(account_balance())
        }

  defstruct [
    :data
  ]

  @doc """
    Use this endpoint to retrieve balances for each currency account belonging to an entity.

    https://api-reference.checkout.com/#operation/getEntityBalances
  """
  @spec get(String.t(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def get(entityId, header_opts \\ []) do
    Checkout.make_request(
      :get,
      "#{@endpoint}/#{entityId}?withCurrencyAccountId=true",
      nil,
      header_opts
    )
  end
end
