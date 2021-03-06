defmodule Yoyaku.Factory do
  use ExMachina.Ecto, repo: Yoyaku.Repo

  @password "o$85To&qqoqWP3ro#Pir"
  @password_hash Bcrypt.hash_pwd_salt(@password)

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: @password

  def phone_no do
    sequence(:phone_no, fn n ->
      number = n |> to_string() |> String.pad_leading(6, "0")
      "+48601" <> number
    end)
  end

  def slot_factory do
    start_time = Timex.now() |> Timex.shift(days: 3) |> DateTime.truncate(:second)
    end_time = start_time |> Timex.shift(minutes: 30)

    %Yoyaku.Slots.Slot{
      capacity: 5,
      start_time: start_time,
      end_time: end_time
    }
  end

  def reservation_factory do
    %Yoyaku.Booking.Reservation{
      email: unique_user_email(),
      first_name: "Example",
      last_name: "User",
      phone_no: "+48601234567",
      confirmed_at: Timex.now(),
      slot: build(:slot)
    }
  end

  def user_factory do
    %Yoyaku.Accounts.User{
      email: unique_user_email(),
      hashed_password: @password_hash,
      password: valid_user_password()
    }
  end
end
