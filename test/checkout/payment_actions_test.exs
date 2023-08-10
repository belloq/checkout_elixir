defmodule Checkout.PaymentActionsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "list payment actions" do
    test "retrieve a list of payment actions by id" do
      use_cassette "payment/get_actions" do
        {:ok, response} = Checkout.Payment.get_actions("pay_t2ducu2keyyebdsklh3n5vw5km")

        refute 0 == length(response)
      end
    end
  end
end
