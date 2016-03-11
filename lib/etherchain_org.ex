defmodule EtherchainOrg do
  use HTTPoison.Base

  @moduledoc """
  Elixir wrapper for etherchain.org api, provides access to ethereum blockchain data
  """
  def process_url(url) do
    "https://etherchain.org/api" <> url
  end

  def process_response_body(body) do
    body
  end

  def supply do
    {:ok, res} = EtherchainOrg.get("/supply")
    res.body
    |> Poison.Parser.parse!
    |> Map.get("data")
    |> hd
    |> Map.get("supply")
  end

  def supply(rounded: true) do
    supply
    |> round
  end

end
