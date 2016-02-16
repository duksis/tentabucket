defmodule Tentabucket.Client do
  defstruct endpoint: "https://api.bitbucket.org/2.0/"

  @type t :: %__MODULE__{endpoint: binary}

  @spec new() :: t
  def new(), do: %__MODULE__{}

  @spec new(binary) :: t
  def new(endpoint) do
    endpoint = if String.ends_with?(endpoint, "/") do
      endpoint
    else
      endpoint <> "/"
    end
    %__MODULE__{endpoint: endpoint}
  end
end
