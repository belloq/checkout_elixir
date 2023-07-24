defmodule Checkout.SubentityTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "onboard sub-entities" do
    test "onboard company" do
      use_cassette "subentity/onboard_company" do
        {:ok, response} =
          Checkout.Subentity.onboard(%{
            reference: "test-company-3",
            contact_details: %{
              phone: %{
                number: "2345678910"
              },
              email_addresses: %{
                primary: "email@test.com"
              }
            },
            profile: %{
              urls: ["https://www.test.com"],
              mccs: ["8299"],
              default_holding_currency: "USD",
              holding_currencies: ["USD"]
            },
            company: %{
              legal_name: "Test Inc.",
              trading_name: "Test company",
              principal_address: %{
                address_line1: "123 Main St.",
                address_line2: "Suite 100",
                city: "San Francisco",
                state: "CA",
                zip: "94105",
                country: "US"
              },
              registered_address: %{
                address_line1: "123 Main St.",
                address_line2: "Suite 100",
                city: "San Francisco",
                state: "CA",
                zip: "94105",
                country: "US"
              },
              representatives: [
                %{
                  first_name: "John",
                  last_name: "Doe",
                  date_of_birth: %{
                    day: 1,
                    month: 1,
                    year: 1980
                  },
                  place_of_birth: %{
                    country: "US"
                  },
                  phone: %{
                    number: "2345678910"
                  },
                  address: %{
                    address_line1: "123 Main St.",
                    address_line2: "Suite 100",
                    city: "San Francisco",
                    state: "CA",
                    zip: "94105",
                    country: "US"
                  }
                }
              ]
            }
          })

        refute response == %{}
        refute response["id"] == nil
      end
    end

    test "onboard individual" do
      use_cassette "subentity/onboard_individual" do
        {:ok, response} =
          Checkout.Subentity.onboard(%{
            reference: "test-individual",
            contact_details: %{
              phone: %{
                number: "2345678910"
              },
              email_addresses: %{
                primary: "email@test.com"
              }
            },
            profile: %{
              urls: ["https://www.test.com"],
              mccs: ["8299"],
              default_holding_currency: "USD",
              holding_currencies: ["USD"]
            },
            individual: %{
              first_name: "John",
              last_name: "Doe",
              trading_name: "Test individual company",
              date_of_birth: %{
                day: 1,
                month: 1,
                year: 1980
              },
              registered_address: %{
                address_line1: "123 Main St.",
                address_line2: "Suite 100",
                city: "San Francisco",
                state: "CA",
                zip: "94105",
                country: "US"
              },
              place_of_birth: %{
                country: "US"
              }
            }
          })

        refute response == %{}
        refute response["id"] == nil
      end
    end
  end

  describe "get sub-entity" do
    test "get sub-entity" do
      use_cassette "subentity/get" do
        {:ok, response} = Checkout.Subentity.get("ent_b66rtcrtd2l7vkx2ldnmt6o2we")
        refute response == %{}
        refute response["id"] == nil
      end
    end
  end
end
