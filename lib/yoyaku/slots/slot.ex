defmodule Yoyaku.Slots.Slot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slots" do
    field :capacity, :integer
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(slot, attrs) do
    slot
    |> cast(attrs, [:start_time, :end_time, :capacity])
    |> validate_required([:start_time, :end_time, :capacity])
    |> exclusion_constraint(:start_time,
      name: :slots_exclusion,
      message: "Slot times overlap with another record"
    )
  end
end
