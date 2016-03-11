defmodule EtherchainOrgTest do
  use ExUnit.Case
  doctest EtherchainOrg

  test "correctly returns number of ether tokens" do
    assert EtherchainOrg.supply >= 70_000_000
  end
end
