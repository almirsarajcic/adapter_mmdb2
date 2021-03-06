defmodule Geolix.Adapter.MMDB2.Record.City do
  @moduledoc """
  Record for `city` information.
  """

  alias Geolix.Adapter.MMDB2.Model

  defstruct [
    :geoname_id,
    :name,
    :names
  ]

  @behaviour Model

  @impl Model
  def from(nil, _), do: nil
  def from(data, nil), do: struct(__MODULE__, data)

  def from(data, locale) do
    result = from(data, nil)
    result = Map.put(result, :name, result.names[locale])

    result
  end
end
