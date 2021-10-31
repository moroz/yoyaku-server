defmodule Yoyaku.BookingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Yoyaku.Booking` context.
  """

  @doc """
  Generate a reservation.
  """
  def reservation_fixture(attrs \\ %{}) do
    {:ok, reservation} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone_no: "some phone_no"
      })
      |> Yoyaku.Booking.create_reservation()

    reservation
  end
end
