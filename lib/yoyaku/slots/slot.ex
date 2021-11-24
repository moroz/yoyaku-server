defmodule Yoyaku.Slots.Slot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slots" do
    field :capacity, :integer
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    has_many :reservations, Yoyaku.Booking.Reservation

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
    |> validate_end_time_after_start_time()
  end

  defp validate_end_time_after_start_time(changeset) do
    start_time = get_change(changeset, :start_time)
    end_time = get_change(changeset, :end_time)

    if start_time && end_time && Timex.after?(start_time, end_time) do
      add_error(changeset, :end_time, "must be after start time")
    else
      changeset
    end
  end
end
