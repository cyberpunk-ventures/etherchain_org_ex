defmodule EtherchainOrgTest do
  use ExUnit.Case
  doctest EtherchainOrg

  test "correctly returns number of ether tokens" do
    {:ok, supply} = EtherchainOrg.supply
    assert supply  >= 70_000_000
  end

  test "correctly returns data about account" do
    id = "0xb794F5eA0ba39494cE839613fffBA74279579268" # account with most ether on balance
    {:ok, response} = EtherchainOrg.account(id)
    account_data = response |> Map.to_list
    assert Vex.valid? account_data, address: [presence: true], balance: [presence: true]
  end

  test "returns data about account transactions" do
    id = "0xb794F5eA0ba39494cE839613fffBA74279579268" # account with most ether on balance
    {:ok, response} = EtherchainOrg.account_tx(id, 0)
    account_data = response  |> hd |> Map.to_list
    assert assert Vex.valid? account_data, hash: [presence: true], sender: [presence: true], recipient: [presence: true]
  end

  
end
