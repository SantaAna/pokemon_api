defmodule PokelixirTest do
  use ExUnit.Case
  alias Pokelixir.Pokemon
  doctest Pokelixir

  describe "new/1" do
    test "create a Pokemon no attributes" do
      assert %Pokemon{} == Pokemon.new([])
    end

    test "create a Pokemon with attributes" do
      properties = [
        id: 6,
        name: "charizard",
        hp: 78,
        attack: 84,
        defense: 78,
        special_attack: 109,
        special_defense: 85,
        speed: 100,
        height: 17,
        weight: 905,
        types: ["fire", "flying"]
      ]

      charizard = struct(Pokemon, properties)

      assert charizard == Pokemon.new(properties)
    end
  end
end
