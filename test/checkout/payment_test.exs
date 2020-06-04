defmodule Checkout.PaymentTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "payment#create_with_id" do
    use_cassette "payment/create_with_id" do
      {:ok, response} = Checkout.Payment.create(%{
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

  test "payment#create_with_id - invalid_response" do
    use_cassette "payment/create_with_id_invalid_response" do
      response = Checkout.Payment.create(%{
        source: %{
          type: "id",
          id: "src_1234",
          cvv: "100",
        },
        amount: 6500,
        currency: "USD",
      })

      assert {:error, _} = response
    end
  end

  test "payment#create_with_token" do
    use_cassette "payment/create_with_token" do
      {:ok, response} = Checkout.Payment.create(%{
        source: %{
          type: "token",
          token: "tok_wpzi5ph5r34uxfgvmxda67myva"
        },
        amount: 100,
        currency: "USD",
      })

      refute response == %{}
      refute response["id"] == nil
    end
  end

  test "payment#create_with_full_card" do
    use_cassette "payment/create_with_full_card" do
      {:ok, response} = Checkout.Payment.create(%{
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

  test "payment#create_with_default" do
    # use_cassette "payment/create_with_default" do
      {:ok, response} = Checkout.Payment.create(%{
        email: "test@example.org",
        value: 100,
        currency: "USD",
      })

      refute response == %{}
      refute response["id"] == nil
    # end
  end
end
