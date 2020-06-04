defmodule Checkout.TokenTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "payment_token#apple_pay" do
    # use_cassette "payment_token/apple_pay" do
      {:ok, response} = Checkout.Token.apple_pay(%{
        version: "EC_v1",
        data: "J/a5u/KyFkXVy4ghO2../+tjRfzjylbX3djJDKPPIBAs=",
        signature: "MIAGCSqGSIb3DQEHAqCAMI..Ld2uMYqksJoO5lMlwAAAAAAAA==",
        header: %{
          applicationData: "BBQUHAgIwgbYMgbNS..ZWxpYW5jZSBvbiB0aGlzIGN==",
          ephemeralPublicKey: "MFkwEwYHKoZIzj0ZIzj0DAQcDQgAE..tf1z9S28unel+C+q7UXiuw==",
          wrappedKey: "3mWagrJNMIIC7jCCAnWgAwIBA..ISW0vvzqY2pcwCgYIKoZIzEAw",
          publicKeyHash: "tqYV+tmG9aMh+l/K6cic..1gUiLjSTM9gEz6Nl0=",
          transactionId: "11c21bd6357a0952f23817e..80b254c3a20734137cf7be168"
        }
      })
      refute response == %{}
      refute response["token"] == nil
    # end
  end
end
