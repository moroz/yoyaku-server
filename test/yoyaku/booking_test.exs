defmodule Yoyaku.BookingTest do
  use Yoyaku.DataCase

  alias Yoyaku.Booking

  def reservation_fixture(opts \\ []) do
    insert(:reservation, opts) |> Repo.reload!()
  end

  describe "reservations" do
    alias Yoyaku.Booking.Reservation

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, phone_no: nil}

    test "list_reservations/0 returns all reservations" do
      reservation = reservation_fixture()
      assert Booking.list_reservations() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Booking.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      slot = insert(:slot)

      valid_attrs = %{
        email: unique_user_email(),
        first_name: "some first_name",
        last_name: "some last_name",
        phone_no: phone_no(),
        slot_id: slot.id
      }

      assert {:ok, %Reservation{} = reservation} = Booking.create_reservation(valid_attrs)
      assert reservation.email == valid_attrs.email
      assert reservation.first_name == "some first_name"
      assert reservation.last_name == "some last_name"
      assert reservation.phone_no == valid_attrs.phone_no
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Booking.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()

      update_attrs = %{
        email: unique_user_email(),
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        phone_no: phone_no()
      }

      assert {:ok, %Reservation{} = reservation} =
               Booking.update_reservation(reservation, update_attrs)

      assert reservation.email == update_attrs.email
      assert reservation.first_name == "some updated first_name"
      assert reservation.last_name == "some updated last_name"
      assert reservation.phone_no == update_attrs.phone_no
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Booking.update_reservation(reservation, @invalid_attrs)
      assert reservation == Booking.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Booking.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Booking.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Booking.change_reservation(reservation)
    end
  end
end
