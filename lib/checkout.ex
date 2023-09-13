defmodule Checkout do
  use HTTPoison.Base

  @live_url "https://api.checkout.com/"
  @sandbox_url "https://api.sandbox.checkout.com/"

  @live_transfers_url "https://transfers.checkout.com/"
  @sandbox_transfers_url "https://transfers.sandbox.checkout.com/"

  def process_url(endpoint) do
    endpoint
    |> api_url()
    |> URI.parse()
    |> remove_path_if_needed(endpoint)
    |> URI.to_string()
    |> Kernel.<>(endpoint)
  end

  def process_request_headers(opts) do
    opts
    |> Enum.concat([
      {"Content-Type", "application/json;charset=UTF-8"},
      {"Authorization", "Bearer #{get_api_key(opts)}"}
    ])
  end

  def process_request_body(body) do
    Jason.encode!(body)
  end

  def process_response_body(body) do
    body
    |> Jason.decode()
    |> case do
      {:ok, data} -> data
      {:error, _} -> {:error, body}
    end
  end

  def make_request(method, endpoint, body \\ "", headers \\ [], options \\ []) do
    options =
      options
      |> Keyword.put(:recv_timeout, 30_000)
      |> Keyword.put(:ssl, [{:versions, [:"tlsv1.2", :"tlsv1.3", :"tlsv1.1", :tlsv1]}])

    case request(method, endpoint, body, headers, options) do
      {:error, _} = err -> err
      {:ok, response} -> handle_response(response)
    end
  end

  defp get_api_key(opts) do
    opts
    |> Keyword.get(:public, false)
    |> case do
      true -> :public
      false -> :secret
    end
    |> get_api_key(opts)
  end

  defp get_api_key(:public, opts) do
    get_api_key(:public_key, "CHECKOUT_PUBLIC_KEY", opts)
  end

  defp get_api_key(:secret, opts) do
    get_api_key(:secret_key, "CHECKOUT_SECRET_KEY", opts)
  end

  defp get_api_key(key, env_var, opts) do
    Keyword.get(opts, key, Application.get_env(:checkout_elixir, key, System.get_env(env_var)))
  end

  defp api_url(endpoint) do
    if String.starts_with?(endpoint, "transfers") do
      transfers_url()
    else
      base_url()
    end
  end

  defp transfers_url do
    if Application.get_env(:checkout_elixir, :sandbox, false) do
      @sandbox_transfers_url
    else
      @live_transfers_url
    end
  end

  defp base_url do
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
      201 -> {:ok, response.body}
      202 -> {:ok, response.body}
      204 -> {:ok, response.body}
      400 -> {:error, response.body}
      401 -> {:error, :unauthorized}
      404 -> {:error, :not_found}
      422 -> {:error, response.body}
    end
  end
end
