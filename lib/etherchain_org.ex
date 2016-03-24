
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

  @doc """
    Function returns a map with the following structure:

    %{
      address: "0x32be343b94f860124dc4fee278fdcbd38c102d88",
      balance: 1.261501069845921e+23,
      nonce: "0",
      code: "0x",
      name: "Poloniex (Cold Wallet)",
      storage: ""
    }
  """
  def account(id) do
    {:ok, response} = EtherchainOrg.get("/account/" <> id)
    %{"data" => data} = response.body |> Poison.Parser.parse!
    data
    |> hd
    |> Enum.map(fn {k,v} -> {String.to_atom(k),v} end)
    |> Enum.reduce(%{}, fn {k,v},acc ->
      Map.merge(acc, %{k => v})
    end)

  end


end
