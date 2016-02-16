defmodule Tentabucket.RepositoriesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentabucket.Repositories

  doctest Tentabucket.Repositories

  @client Tentabucket.Client.new()

  setup_all do
    HTTPoison.start
  end

  test "list_account/3" do
    use_cassette "repositories#list_account" do
      %{"values" => [%{"full_name" => full_name}]} = list_account("duksis", @client)
      assert full_name == "duksis/tentabucket"
    end
  end
end
