defmodule EtherchainOrgTest do
  use ExUnit.Case
  doctest EtherchainOrg

  test "correctly returns number of ether tokens" do
    assert EtherchainOrg.supply >= 70_000_000
  end

  test "correctly returns data about account" do
    id = "0xb794F5eA0ba39494cE839613fffBA74279579268" # account with most ether on balance
    account_data = EtherchainOrg.account(id) |> Map.to_list
    assert Vex.valid? account_data, address: [presence: true], balance: [presence: true]
  end
end
