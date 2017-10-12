defmodule Checkout.CardTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "card#create" do
    use_cassette "card/create" do
      {:ok, response} = Checkout.Card.create("cust_19B16865-A90D-491D-8E2E-99655D250FAB", "card_tok_62706885-13AB-4C3B-8E0D-F8B31ABFCAC4")
      refute response == %{}
    end
  end

  test "card#get" do
    use_cassette "card/get" do
      {:ok, response} = Checkout.Card.get("cust_19B16865-A90D-491D-8E2E-99655D250FAB", "card_49E69E61-8E35-40E0-AA10-B0B15F198275")
      refute response == %{}
    end
  end

  test "card#list" do
    use_cassette "card/list" do
      {:ok, response} = Checkout.Card.list("cust_19B16865-A90D-491D-8E2E-99655D250FAB")
      assert %{count: 2} = response
    end
  end

  test "card#update" do
    use_cassette "card/update" do
      {:ok, response} = Checkout.Card.update("cust_19B16865-A90D-491D-8E2E-99655D250FAB", "card_49E69E61-8E35-40E0-AA10-B0B15F198275", %{name: "Test User"})
      assert response == %{message: "ok"}
    end
  end

  test "card#delete" do
    use_cassette "card/delete" do
      {:ok, response} = Checkout.Card.delete("cust_19B16865-A90D-491D-8E2E-99655D250FAB", "card_49E69E61-8E35-40E0-AA10-B0B15F198275")
      assert response == %{message: "ok"}
    end
  end
end
