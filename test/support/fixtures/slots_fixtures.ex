defmodule Yoyaku.SlotsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Yoyaku.Slots` context.
  """

  @doc """
  Generate a slot.
  """
  def slot_fixture(attrs \\ %{}) do
    {:ok, slot} =
      attrs
      |> Enum.into(%{
        capacity: 42,
        end_time: ~N[2021-10-29 20:13:00],
        start_time: ~N[2021-10-29 20:13:00]
      })
      |> Yoyaku.Slots.create_slot()

    slot
  end
end
