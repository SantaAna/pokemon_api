defmodule ApiTests do
  use ExUnit.Case
  alias Pokelixir.Api

  describe "api_to_poke_struct/1" do
    test "charizar" do
      chaz = %Pokelixir.Pokemon{
        id: 6,
        name: "charizard",
        hp: 78,
        attack: 84,
        defense: 78,
        special_attack: 109,
        special_defense: 85,
        speed: 100,
        weight: 905,
        height: 17,
        types: ["fire", "flying"]
      }

      assert {:ok, chaz} == Api.api_to_poke_struct("charizard")
    end

    test "non-existent pokemon returns error" do
      assert {:error, :client_error} == Api.api_to_poke_struct("chazisrad")
    end
  end
end
