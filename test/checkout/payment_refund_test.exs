defmodule Checkout.RefundTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "refund a payment" do
    test "creates a refund" do
      use_cassette "refund/refund" do
        {:ok, response} =
          Checkout.Payment.refund("pay_t2ducu2keyyebdsklh3n5vw5km", %{
            amount: 11393,
            amount_allocations: [
              %{
                id: "ent_mjkatfyucvlw6vlmq26gixivsa",
                amount: 11393,
                commission: %{
                  amount: 1393
                }
              }
            ]
          })

        refute response == %{}
        refute response["action_id"] == nil
      end
    end
  end
end
