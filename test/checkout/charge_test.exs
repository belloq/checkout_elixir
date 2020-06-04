defmodule Checkout.ChargeTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "charge#create_with_id" do
    use_cassette "charge/create_with_id" do
      {:ok, response} = Checkout.Charge.create(%{
        source: %{
          type: "id",
          id: "src_en2w67spfevehol7rh6m5zokeq",
          cvv: "100",
        },
        amount: 6500,
        currency: "USD",
      })

      refute response == %{}
      refute response["id"] == nil
    end
  end

  test "charge#create_with_id - invalid_response" do
    use_cassette "charge/create_with_id_invalid_response" do
      response = Checkout.Charge.create(%{
        cardId: "card_9F2123D1-4F25-4F3D-AD68-344C01C28B59",
        email: "test@example.org",
        value: 100,
        currency: "USD",
      })

      assert {:error, _} = response
    end
  end

  test "charge#create_with_token" do
    use_cassette "charge/create_with_token" do
      {:ok, response} = Checkout.Charge.create(%{
        cardToken: "card_tok_CB9C10E3-24CC-4A82-B50A-4DEFDCB15580",
        email: "test@example.org",
        value: 100,
        currency: "USD",
      })

      refute response == %{}
      refute response["id"] == nil
    end
  end

  test "charge#create_with_full_card" do
    use_cassette "charge/create_with_full_card" do
      {:ok, response} = Checkout.Charge.create(%{
        amount: 100,
        currency: "USD",
        source: %{
          type: "card",
          number: "4242424242424242",
          expiry_month: "08",
          expiry_year: "2022",
          cvv: 100
        }
      })

      refute response == %{}
      refute response["id"] == nil
    end
  end

  test "charge#create_with_default" do
    use_cassette "charge/create_with_default" do
      {:ok, response} = Checkout.Charge.create(%{
        email: "test@example.org",
        value: 100,
        currency: "USD",
      })

      refute response == %{}
      refute response["id"] == nil
    end
  end

  test "charge#get" do
    use_cassette "charge/get" do
      {:ok, response} = Checkout.Charge.get("charge_B41BEAAC175U76BD3EE1")

      refute response == %{}
    end
  end

  test "charge#update" do
    use_cassette "charge/update" do
      {:ok, response} = Checkout.Charge.update("charge_B41BEAAC175U76BD3EE1", %{description: "charge updated"})

      assert response == %{"message" => "ok"}
    end
  end

  test "charge#capture" do
    use_cassette "charge/capture" do
      {:ok, response} = Checkout.Charge.capture("charge_B41BEAAC175U76BD3EE1")

      refute response == %{}
      assert response["status"] == "Captured"
    end
  end

  test "charge#void" do
    use_cassette "charge/void" do
      {:ok, response} = Checkout.Charge.void("charge_B41BEAAC175U76BD3EE1")

      refute response == %{}
      assert response["status"] == "Voided"
    end
  end

  test "charge#refund" do
    use_cassette "charge/refund" do
      {:ok, response} = Checkout.Charge.refund("charge_B41BEAAC175U76BD3EE1")

      refute response == %{}
      assert response["status"] == "Refunded"
    end
  end

  test "charge#history" do
    use_cassette "charge/history" do
      {:ok, response} = Checkout.Charge.history("charge_B41BEAAC175U76BD3EE1")

      refute response == %{}
    end
  end

  test "charge#localpayment" do
    use_cassette "charge/localpayment" do
      {:ok, response} = Checkout.Charge.localpayment(%{
        email: "test@email.com",
        localPayment: %{
          lppId: "lpp_19",
          userData: %{}
        },
        paymentToken: "pay_tok_76918102-264F-40DF-A6D4-987BAE5939B3"
      })

      refute response == %{}
    end
  end
end
