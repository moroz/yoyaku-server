defmodule Yoyaku.BookingTest do
  use Yoyaku.DataCase

  alias Yoyaku.Booking

  describe "reservations" do
    alias Yoyaku.Booking.Reservation

    import Yoyaku.BookingFixtures

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
      valid_attrs = %{email: "some email", first_name: "some first_name", last_name: "some last_name", phone_no: "some phone_no"}

      assert {:ok, %Reservation{} = reservation} = Booking.create_reservation(valid_attrs)
      assert reservation.email == "some email"
      assert reservation.first_name == "some first_name"
      assert reservation.last_name == "some last_name"
      assert reservation.phone_no == "some phone_no"
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Booking.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      update_attrs = %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", phone_no: "some updated phone_no"}

      assert {:ok, %Reservation{} = reservation} = Booking.update_reservation(reservation, update_attrs)
      assert reservation.email == "some updated email"
      assert reservation.first_name == "some updated first_name"
      assert reservation.last_name == "some updated last_name"
      assert reservation.phone_no == "some updated phone_no"
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
