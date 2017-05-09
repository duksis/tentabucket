defmodule TentabucketTest do
  use ExUnit.Case
  use PropCheck
  import Tentabucket
  alias Tentabucket.Client
  doctest Tentabucket

  setup_all do
    :meck.new(JSX, [:no_link])

    on_exit fn ->
      :meck.unload JSX
    end
  end

  test "process response on a 200 response" do
    :meck.expect(JSX, :decode!, 1, :decoded_json)
    assert process_response(%HTTPoison.Response{ status_code: 200,
      headers: %{},
      body: "json" }) == :decoded_json
    assert :meck.validate(JSX)
  end

  test "process response on a non-200 response" do
    :meck.expect(JSX, :decode!, 1, :decoded_json)
    assert process_response(%HTTPoison.Response{ status_code: 404,
      headers: %{},
      body: "json" }) == {404, :decoded_json}
    assert :meck.validate(JSX)
  end

  test "process response on a non-200 response and empty body" do
    assert process_response(%HTTPoison.Response{ status_code: 404,
      headers: %{},
      body: "" }) == {404, nil}
  end

  defp username(), do: non_empty(utf8())
  defp password(), do: non_empty(utf8())
  defp headers(), do: list(tuple([non_empty(utf8()), any()]))
  defp token(), do: non_empty(utf8())

  property "client usernames and passwords are base64-encoded authorization headers" do
    forall {user, pass, head} in {username(), password(), headers()} do
      expected_result = {"Authorization", "Basic #{ Base.encode64(user <> ":" <> pass) }"}

      Tentabucket.authorization_header(%Client{username: user, password: pass}, head)
      |> Enum.member?(expected_result)

    end
  end

  property "client tokens are bearer authorization headers" do
    forall {tok, head} in {token(), headers()} do
      expected_result = {"Authorization", "Bearer #{tok}"}

      Tentabucket.authorization_header(%Client{token: tok}, head)
      |> Enum.member?(expected_result)
    end
  end

  property "authorization prefers token over username/password" do
    forall {user, pass, tok, head} in {username(), password(), token(), headers()} do
      token_auth = {"Authorization", "Bearer #{tok}"}
      basic_auth = {"Authorization", "Basic #{ Base.encode64(user <> ":" <> pass) }"}

      new_headers = Tentabucket.authorization_header(%Client{token: tok, username: user, password: pass}, head)
      Enum.member?(new_headers, token_auth) and not Enum.member?(new_headers, basic_auth)
    end
  end
end
