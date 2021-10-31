defmodule YoyakuWeb.Api.Resolvers.ReservationResolvers do
  alias Yoyaku.Booking

  def make_reservation(%{params: params}, _) do
    with {:ok, reservation} <- Booking.create_reservation(params) do
      {:ok, %{success: true, data: reservation}}
    end
  end
end
