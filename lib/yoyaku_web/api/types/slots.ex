defmodule YoyakuWeb.Api.Types.Slots do
  use Absinthe.Schema.Notation
  import YoyakuWeb.Macros
  alias YoyakuWeb.Api.Resolvers.SlotResolvers

  object :slot do
    field :id, non_null(:id)
    field :start_time, non_null(:datetime)
    field :end_time, non_null(:datetime)
    field :capacity, non_null(:integer)

    timestamps()
  end

  input_object :slot_params do
    field :start_time, :string
    field :end_time, :string
    field :capacity, :integer
  end

  object :slot_mutation_result do
    field :success, non_null(:boolean)
    field :data, :slot
    field :errors, :json
  end

  object :slot_queries do
    field :slot, :slot do
      arg(:id, non_null(:id))
      resolve(&SlotResolvers.get_slot/2)
    end

    field :slots, non_null(list_of(non_null(:slot))) do
      resolve(&SlotResolvers.list_slots/2)
    end
  end

  object :slot_mutations do
    field :create_slot, non_null(:slot_mutation_result) do
      arg(:params, non_null(:slot_params))
      resolve(&SlotResolvers.create_slot/2)
    end
  end
end
