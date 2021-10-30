defmodule Yoyaku.Repo.Migrations.CreateSlots do
  use Ecto.Migration

  def change do
    execute "create extension if not exists btree_gist with schema public"

    create table(:slots) do
      add :start_time, :naive_datetime, null: false
      add :end_time, :naive_datetime, null: false
      add :capacity, :integer, null: false, default: 0

      timestamps()
    end

    execute "alter table slots add constraint slots_end_time_must_be_after_start_time check (end_time > start_time)"

    execute "alter table slots add constraint slots_exclusion exclude using gist(tsrange(start_time, end_time) with &&)"
  end

  def down do
    drop table(:slots)
  end
end
