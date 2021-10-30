defmodule Yoyaku.SlotsTest do
  use Yoyaku.DataCase

  alias Yoyaku.Slots

  describe "slots" do
    alias Yoyaku.Slots.Slot

    import Yoyaku.SlotsFixtures

    @invalid_attrs %{capacity: nil, end_time: nil, start_time: nil}

    test "list_slots/0 returns all slots" do
      slot = slot_fixture()
      assert Slots.list_slots() == [slot]
    end

    test "get_slot!/1 returns the slot with given id" do
      slot = slot_fixture()
      assert Slots.get_slot!(slot.id) == slot
    end

    test "create_slot/1 with valid data creates a slot" do
      valid_attrs = %{capacity: 42, end_time: ~N[2021-10-29 20:13:00], start_time: ~N[2021-10-29 20:13:00]}

      assert {:ok, %Slot{} = slot} = Slots.create_slot(valid_attrs)
      assert slot.capacity == 42
      assert slot.end_time == ~N[2021-10-29 20:13:00]
      assert slot.start_time == ~N[2021-10-29 20:13:00]
    end

    test "create_slot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Slots.create_slot(@invalid_attrs)
    end

    test "update_slot/2 with valid data updates the slot" do
      slot = slot_fixture()
      update_attrs = %{capacity: 43, end_time: ~N[2021-10-30 20:13:00], start_time: ~N[2021-10-30 20:13:00]}

      assert {:ok, %Slot{} = slot} = Slots.update_slot(slot, update_attrs)
      assert slot.capacity == 43
      assert slot.end_time == ~N[2021-10-30 20:13:00]
      assert slot.start_time == ~N[2021-10-30 20:13:00]
    end

    test "update_slot/2 with invalid data returns error changeset" do
      slot = slot_fixture()
      assert {:error, %Ecto.Changeset{}} = Slots.update_slot(slot, @invalid_attrs)
      assert slot == Slots.get_slot!(slot.id)
    end

    test "delete_slot/1 deletes the slot" do
      slot = slot_fixture()
      assert {:ok, %Slot{}} = Slots.delete_slot(slot)
      assert_raise Ecto.NoResultsError, fn -> Slots.get_slot!(slot.id) end
    end

    test "change_slot/1 returns a slot changeset" do
      slot = slot_fixture()
      assert %Ecto.Changeset{} = Slots.change_slot(slot)
    end
  end
end
