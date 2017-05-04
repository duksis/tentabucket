defmodule Tentabucket.Repositories do
  import Tentabucket
  alias Tentabucket.Client

  @doc """
    List of repositories for an account.

    ## Examples
      Tentabucket.Repositories.list_account("duksis", client)

    More info at: https://developer.github.com/v3/repos/#list-your-repositories
  """
  @spec list_account(binary, Client.t, Keyword.t) :: Tentabucket.response
  def list_account(owner, client \\ Client.new, opts \\ []) do
    get "repositories/#{owner}", client, opts
  end
end

