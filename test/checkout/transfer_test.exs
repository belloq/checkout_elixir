defmodule Checkout.TransferTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create a transfer" do
    test "create a transfer" do
      use_cassette "transfer/create" do
        {:ok, response} =
          Checkout.Transfer.create(
            %{
              reference: "b52fee22-19d8-4171-ac75-3954f4c86bd5",
              transfer_type: "commission",
              source: %{
                id: "ent_id",
                amount: 10_000
              },
              destination: %{
                id: "ent_id"
              }
            },
            [{"Cko-Idempotency-Key", "b52fee22-19d8-4171-ac75-3954f4c86b25"}]
          )

        refute response == %{}
        refute response["id"] == nil
      end
    end
  end

  describe "get transfer" do
    test "retrieve a transfer" do
      use_cassette "transfer/get" do
        {:ok, response} = Checkout.Transfer.get("tra_id")

        assert %{
                 "id" => "tra_id"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "transfer/get_not_found" do
        assert {:error, :not_found} = Checkout.Transfer.get("not_tra_id")
      end
    end
  end
end
