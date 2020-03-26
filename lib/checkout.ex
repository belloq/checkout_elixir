defmodule Checkout do
  use HTTPoison.Base

  @live_url "https://api2.checkout.com/v2/"
  @sandbox_url "https://sandbox.checkout.com/api2/v2/"

  def process_url(endpoint) do
    url =
      api_url()
      |> URI.parse
      |> remove_path_if_needed(endpoint)
      |> URI.to_string

    url <> endpoint
  end

  def process_request_headers(secret_key \\ true) do
    [
      {"Content-Type", "application/json;charset=UTF-8"},
      {"Authorization",
        if secret_key do
          Application.get_env(:checkout_elixir, :secret_key, System.get_env("CHECKOUT_SECRET_KEY"))
        else
          Application.get_env(:checkout_elixir, :public_key, System.get_env("CHECKOUT_PUBLIC_KEY"))
        end
      }
    ]
  end

  def process_request_body(body) do
    Jason.encode!(body)
  end

  def process_response_body(body) do
    body
    |> Jason.decode
    |> case do
      {:ok, data} -> data
      {:error, _} -> {:error, body}
    end
  end

  def make_request(method, endpoint, body \\ "", headers \\ [], options \\ []) do
    options = Keyword.put(options, :recv_timeout, 30_000)
    {:ok, response} = request(method, endpoint, body, headers, options)

    case response.body do
      {:error, _} = err -> err
      _ -> handle_response(response)
    end
  end

  defp api_url do
    if Application.get_env(:checkout_elixir, :sandbox, false) do
      @sandbox_url
    else
      @live_url
    end
  end

  defp remove_path_if_needed(uri, endpoint) do
    if String.contains?(endpoint, "applepay") do
      Map.put(uri, :path, "/")
    else
      uri
    end
  end

  defp handle_response(response) do
    case response.status_code do
      200 -> {:ok, response.body}
      400 -> {:error, response.body}
      401 -> {:error, :unauthorized}
      404 -> {:error, :not_found}
    end
  end
end
