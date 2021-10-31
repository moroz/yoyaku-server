defmodule Yoyaku.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :email, :string, null: false
      add :phone_no, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :slot_id, references(:slots, on_delete: :nothing), null: false
      add :confirmed_at, :utc_datetime

      timestamps()
    end

    create index(:reservations, [:slot_id])
  end
end
