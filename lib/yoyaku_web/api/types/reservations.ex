defmodule YoyakuWeb.Api.Types.Reservations do
  use Absinthe.Schema.Notation
  import YoyakuWeb.Macros
  import YoyakuWeb.Api.Middleware.LazyPreload

  object :reservation do
    field :email, non_null(:string)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :phone_no, non_null(:string)
    field :confirmed_at, :datetime

    field :slot, non_null(:slot) do
      lazy_preload(:slot)
    end

    timestamps()
  end

  input_object :reservation_params do
    field :slot_id, non_null(:id)
  end
end
