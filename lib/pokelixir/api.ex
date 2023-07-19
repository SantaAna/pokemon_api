defmodule Pokelixir.Api do
  @base_url "https://pokeapi.co/api/v2/"
  @success_codes 200..299
  @client_error_codes 400..499
  @server_error_codes 500..599

  def get_base_url(), do: @base_url

  def request_pokemon(pokemon_name) do
    reply =
      Finch.build(:get, @base_url <> "pokemon/#{pokemon_name}")
      |> Finch.request!(Finch)

    case reply do
      %Finch.Response{status: status} when status in @success_codes ->
        {:ok, Jason.decode!(reply.body)}

      %Finch.Response{status: status} when status in @client_error_codes ->
        {:error, :client_error}

      %Finch.Response{status: status} when status in @server_error_codes ->
        {:error, :server_error}
    end
  end

  def api_to_poke_struct(pokemon_name) do
    case request_pokemon(pokemon_name) do
      {:ok, api_response} ->
        keys = Map.keys(%Pokelixir.Pokemon{}) |> Enum.reject(&(&1 == :__struct__))
        values = Enum.map(keys, &extract(&1, api_response))
        {:ok, struct(Pokelixir.Pokemon, values)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def extract(:id, api_response), do: {:id, extract_id(api_response)}
  def extract(:name, api_response), do: {:name, extract_name(api_response)}
  def extract(:hp, api_response), do: {:hp, extract_hp(api_response)}
  def extract(:attack, api_response), do: {:attack, extract_attack(api_response)}

  def extract(:special_attack, api_response),
    do: {:special_attack, extract_special_attack(api_response)}

  def extract(:defense, api_response), do: {:defense, extract_defense(api_response)}

  def extract(:special_defense, api_response),
    do: {:special_defense, extract_special_defense(api_response)}

  def extract(:speed, api_response), do: {:speed, extract_speed(api_response)}
  def extract(:height, api_response), do: {:height, extract_height(api_response)}
  def extract(:weight, api_response), do: {:weight, extract_weight(api_response)}
  def extract(:types, api_response), do: {:types, extract_types(api_response)}

  def extract_id(%{"id" => id}), do: id
  def extract_name(%{"name" => name}), do: name

  def extract_height(%{"height" => height}), do: height
  def extract_weight(%{"weight" => weight}), do: weight

  def extract_types(%{"types" => types}) do
    for %{"type" => %{"name" => type_name}} <- types, do: type_name
  end

  def extract_speed(api_response) do
    extract_stat(api_response, "speed")
  end

  def extract_hp(api_response) do
    extract_stat(api_response, "hp")
  end

  def extract_attack(api_response) do
    extract_stat(api_response, "attack")
  end

  def extract_defense(api_response) do
    extract_stat(api_response, "defense")
  end

  def extract_special_attack(api_response) do
    extract_stat(api_response, "special-attack")
  end

  def extract_special_defense(api_response) do
    extract_stat(api_response, "special-defense")
  end

  def extract_stat(%{"stats" => stat_list}, stat_name) do
    for stat <- stat_list, stat["stat"]["name"] == stat_name, reduce: nil do
      _acc -> stat["base_stat"]
    end
  end
end
