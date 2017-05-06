defmodule Tentabucket do
  use HTTPoison.Base
  alias Tentabucket.Client

  @default_headers [{"User-agent", "tentabucket"}, {"Content-Type", "application/json"}]
  @type response :: {integer, any} | :jsx.json_term

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%HTTPoison.Response{status_code: 200, body: ""}), do: nil
  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: JSX.decode!(body)
  def process_response(%HTTPoison.Response{status_code: status_code, body: ""}), do: { status_code, nil }
  def process_response(%HTTPoison.Response{status_code: status_code, body: body }), do: { status_code, JSX.decode!(body) }

  def get(path, client, params \\ []) do
    initial_url = url(client, path)
    url = add_params_to_url(initial_url, params)
    _request(:get, url, nil)
  end

  def _request(method, url, auth, body \\ "") do
    json_request(method, url, body, authorization_header(auth, @default_headers))
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    request!(method, url, JSX.encode!(body), headers, [{:ssl, [versions: [:"tlsv1.2"]]} |options]) |> process_response
  end

  @spec url(client :: Client.t, path :: binary) :: binary
  defp url(_client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  defp add_params_to_url(url, params) do
    <<url :: binary, build_qs(params) :: binary>>
  end

  @spec build_qs([{atom, binary}]) :: binary
  defp build_qs([]), do: ""
  defp build_qs(kvs), do: to_string('?' ++ URI.encode_query(kvs))

  def authorization_header(%Client{token: token}, headers) when not is_nil(token) do
    [
      {"Authorization", "Bearer #{token}"}
      | headers
    ]
  end
  def authorization_header(%Client{username: username, password: password}, headers) when not is_nil(username) and not is_nil(password) do
    base64_encoded_username_password = "#{username}:#{password}" |> Base.encode64
    [
      {"Authorization", "Basic #{base64_encoded_username_password}"}
      | headers
    ]
  end
  def authorization_header(_, headers), do: headers
end
