defmodule TentabucketTest do
  use ExUnit.Case
  import Tentabucket
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
end
