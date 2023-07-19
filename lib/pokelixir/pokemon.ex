defmodule Pokelixir.Pokemon do
  defstruct [
    :id,
    :name,
    :hp,
    :attack,
    :defense,
    :special_attack,
    :special_defense,
    :speed,
    :weight,
    :height,
    :types
  ]

  @doc "create a new Pokemon struct using passed in values from a keyword list. Use default values for any property not passed in"
  def new(opts) do
    %__MODULE__{
      id: opts[:id] || nil,
      name: opts[:name] || nil,
      hp: opts[:hp] || nil,
      attack: opts[:attack] || nil,
      defense: opts[:defense] || nil,
      special_attack: opts[:special_attack] || nil,
      special_defense: opts[:special_defense] || nil,
      speed: opts[:speed] || nil,
      weight: opts[:weight] || nil,
      height: opts[:height] || nil,
      types: opts[:types] || nil
    }
  end
end
