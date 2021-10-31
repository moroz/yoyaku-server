defmodule YoyakuWeb.Api.Types.Reservations do
  use Absinthe.Schema.Notation
  import YoyakuWeb.Macros
  import YoyakuWeb.Api.Middleware.LazyPreload
  alias YoyakuWeb.Api.Resolvers.ReservationResolvers

  object :reservation do
    field :id, non_null(:id)
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
    field :first_name, :string
    field :last_name, :string
    field :phone_no, :string
    field :email, :string
  end

  object :reservation_mutation_result do
    field :success, non_null(:boolean)
    field :data, :reservation
    field :errors, :json
  end

  object :reservation_mutations do
    field :make_reservation, non_null(:reservation_mutation_result) do
      arg(:params, non_null(:reservation_params))
      resolve(&ReservationResolvers.make_reservation/2)
    end
  end
end
