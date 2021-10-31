defmodule Yoyaku.Booking.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(email first_name last_name phone_no)a
  @cast @required ++ [:confirmed_at]

  schema "reservations" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_no, :string
    field :confirmed_at, :utc_datetime
    belongs_to :slot, Yoyaku.Slots.Slot

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, @cast)
    |> validate_required(@required)
    |> EmailTldValidator.Ecto.validate_email()
  end
end
