defmodule Checkout.InstrumentTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create instrument" do
    test "creates an instrument" do
      use_cassette "instrument/create" do
        {:ok, response} =
          Checkout.Instrument.create(%{
            type: "token",
            token: "tok_hcb7bxspgd6ujkzq2s6oaqurnu",
            customer: %{
              id: "cus_l5f5yegwznruxpndoopmvsrjvi"
            }
          })

        refute response == %{}
        refute response["id"] == nil
      end
    end
  end

  describe "get instrument" do
    test "retrieve an instrument" do
      use_cassette "instrument/get" do
        {:ok, response} = Checkout.Instrument.get("src_rt5wvrqnuooufeamtaqk2tjhky")

        assert %{
                 "id" => "src_rt5wvrqnuooufeamtaqk2tjhky",
                 "last4" => "4242",
                 "scheme" => "VISA",
                 "customer" => %{
                   "id" => "cus_l5f5yegwznruxpndoopmvsrjvi",
                   "email" => "user@domain.com"
                 }
               } = response
      end
    end
  end
end
