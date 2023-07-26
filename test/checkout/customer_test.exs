defmodule Checkout.CustomerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create customer" do
    test "create a customer" do
      use_cassette "customer/create" do
        {:ok, response} =
          Checkout.Customer.create(%{
            email: "user@domain.com",
            name: "John Doe"
          })

        refute response == %{}
        refute response["id"] == nil
      end
    end
  end

  describe "get customer" do
    test "retrieve a customer" do
      use_cassette "customer/get" do
        {:ok, response} = Checkout.Customer.get("cus_l5f5yegwznruxpndoopmvsrjvi")

        assert %{
                 "id" => "cus_l5f5yegwznruxpndoopmvsrjvi",
                 "name" => "John Doe",
                 "email" => "user@domain.com"
               } = response
      end
    end
  end
end
