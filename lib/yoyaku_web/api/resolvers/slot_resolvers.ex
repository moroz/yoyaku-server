defmodule YoyakuWeb.Api.Resolvers.SlotResolvers do
  alias Yoyaku.Slots

  def get_slot(%{id: id}, _) do
    {:ok, Slots.get_slot!(id)}
  end

  def list_slots(_, _) do
    {:ok, Slots.list_slots()}
  end

  def create_slot(%{params: params}, _) do
    with {:ok, slot} <- Slots.create_slot(params) do
      {:ok, %{success: true, data: slot}}
    end
  end
end
