defmodule Checkout.Subentity do
  @moduledoc """
  Checkout API reference: https://api-reference.checkout.com/#tag/Platforms
  """

  @endpoint "accounts/entities"

  @type phone :: %{
          number: String.t()
        }

  @type email_addresses :: %{
          primary: String.t()
        }

  @type contact_details :: %{
          phone: phone,
          email_addresses: email_addresses
        }

  @type profile :: %{
          urls: list(String.t()),
          mccs: list(String.t()),
          default_holding_currency: String.t(),
          holding_currencies: list(String.t())
        }

  @type address :: %{
          address_line1: String.t(),
          address_line2: String.t(),
          city: String.t(),
          state: String.t(),
          zip: String.t(),
          country: String.t()
        }

  @type file :: %{
          file_id: String.t(),
          type: String.t()
        }

  @type document :: %{
          type: String.t(),
          front: String.t(),
          back: String.t()
        }

  @type identification :: %{
          national_id_number: String.t(),
          document: document
        }

  @type date :: %{
          day: integer,
          month: integer,
          year: integer
        }

  @type country :: %{
          country: String.t()
        }

  @type individual :: %{
          first_name: String.t(),
          middle_name: String.t() | nil,
          last_name: String.t(),
          trading_name: String.t() | nil,
          national_tax_id: String.t() | nil,
          address: address | nil,
          registered_address: address | nil,
          identification: identification | nil,
          phone: phone | nil,
          date_of_birth: date | nil,
          place_of_birth: country | nil,
          roles: list(String.t())
        }

  @type financial_documents :: %{
          bank_statement: file,
          financial_statement: file
        }

  @type financial_details :: %{
          annual_processing_volume: integer | nil,
          average_transaction_value: integer | nil,
          highest_transaction_value: integer | nil,
          documents: financial_documents | nil
        }

  @type company :: %{
          business_registration_number: String.t() | nil,
          business_type: String.t() | nil,
          legal_name: String.t(),
          trading_name: String.t(),
          principal_address: address | nil,
          registered_address: address | nil,
          document: file | nil,
          representatives: list(individual),
          financial_details: financial_details | nil
        }

  @type onboard_params :: %{
          required(:reference) => String.t(),
          required(:contact_details) => contact_details,
          required(:profile) => profile,
          optional(:company) => company,
          optional(:individual) => individual
        }

  @type capability :: %{
          available: boolean(),
          enabled: boolean()
        }

  @type capabilities :: %{
          payments: capability,
          payouts: capability
        }

  @type requirement :: %{
          field: String.t(),
          reason: String.t()
        }

  @type t :: %__MODULE__{
          id: String.t(),
          reference: String.t(),
          status: String.t(),
          instruments: list(any()),
          contact_details: contact_details,
          profile: profile,
          company: company,
          individual: individual,
          capabilities: capabilities,
          requirements_due: list(requirement)
        }

  defstruct [
    :id,
    :reference,
    :status,
    :instruments,
    :contact_details,
    :profile,
    :company,
    :individual,
    :capabilities,
    :requirements_due
  ]

  @doc """
    Onboard a sub-entity so they can start receiving payments.
    Once created, Checkout.com will run due diligence checks.
    If the checks are successful, we'll enable payment capabilities for that sub-entity and they will start receiving payments.

    https://api-reference.checkout.com/#operation/onboardSubEntity
  """
  @spec onboard(onboard_params, Keyword.t()) :: {:ok, t()} | {:error, map()}
  def onboard(params, header_opts \\ []) do
    Checkout.make_request(:post, @endpoint, params, header_opts)
  end

  @doc """
    Use this endpoint to retrieve a sub-entity and its full details.

    https://api-reference.checkout.com/#operation/getSubEntityDetails
  """
  @spec get(String.t(), Keyword.t()) :: {:ok, t()} | {:error, map()}
  def get(id, header_opts \\ []) do
    Checkout.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end
end
