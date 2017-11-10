defmodule Checkout.CustomerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "customer#create" do
    use_cassette "customer/create" do
      {:ok, response} = Checkout.Customer.create(%{email: "test@example.org"})
      refute response == %{}
    end
  end

  test "customer#get_with_email" do
    use_cassette "customer/get_with_email" do
      {:ok, response} = Checkout.Customer.get("test@example.org")
      refute response == %{}
    end
  end

  test "customer#get_with_id" do
    use_cassette "customer/get_with_id" do
      {:ok, response} = Checkout.Customer.get("cust_F3DF0803-19BA-4AFE-9215-A8C90B32FFD7")
      refute response == %{}
    end
  end

  test "customer#list" do
    use_cassette "customer/list" do
      {:ok, response} = Checkout.Customer.list(nil, nil, 1)
      assert %{"count" => 1} = response
    end
  end

  test "customer#update" do
    use_cassette "customer/update" do
      {:ok, response} = Checkout.Customer.update("cust_F3DF0803-19BA-4AFE-9215-A8C90B32FFD7", %{name: "Test User"})
      assert response == %{"message" => "ok"}
    end
  end

  test "customer#delete" do
    use_cassette "customer/delete" do
      {:ok, response} = Checkout.Customer.delete("cust_F3DF0803-19BA-4AFE-9215-A8C90B32FFD7")
      assert response == %{"message" => "ok"}
    end
  end
end
