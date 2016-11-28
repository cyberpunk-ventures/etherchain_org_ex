
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
    supply = res.body
    |> Poison.Parser.parse!
    |> Map.get("data")
    |> hd
    |> Map.get("supply")
    {:ok, supply}
  end

  def supply(rounded: true) do
    {:ok, supply_float} = supply
    {:ok, round(supply_float)}
  end

  @doc """
    Function returns a map with the following schema:

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
    result = data
    |> hd
    |> convert_string_keys_to_atom
    {:ok, result}
  end

  @doc """
  https://etherchain.org/documentation/api/#api-Accounts-GetAccountIdTxOffset
  Returns a list of transactions maps with the schema matching the following example:
    %{
         hash: "0xa04966d391d6e3499ab1cab91b1db7723567025a3b64bace7eceec98403241c4",
         sender: "0xb794f5ea0ba39494ce839613fffba74279579268",
         recipient: "0x32be343b94f860124dc4fee278fdcbd38c102d88",
         accountNonce: "33",
         price: 60000000000,
         gasLimit: 21000,
         amount: 5e+22,
         block_id: 1201932,
         time: "2016-03-23T10:48:37.000Z",
         newContract: 0,
         isContractTx: null,
         blockHash: "0xc4724a224a90aa843f0c06f5f66b69262fb9eab0d81bc3a101ae9f66f7fe4b52",
         parentHash: "0xa04966d391d6e3499ab1cab91b1db7723567025a3b64bace7eceec98403241c4",
         txIndex: null
     }
  """
  def account_tx(id, offset) when is_integer(offset) and is_bitstring(id) do
    {:ok, response} = EtherchainOrg.get "/account/#{id}/tx/#{offset}"
    %{"data" => data} = Poison.Parser.parse!(response.body)
    txs = Enum.map(data, &convert_string_keys_to_atom/1)
    {:ok, txs}
  end

  defp convert_string_keys_to_atom(m) do
    m
    |> Enum.map(fn {k,v} -> {String.to_atom(k),v} end)
    |> Enum.reduce(%{}, fn {k,v},acc ->
      Map.merge(acc, %{k => v})
    end)
  end

end
