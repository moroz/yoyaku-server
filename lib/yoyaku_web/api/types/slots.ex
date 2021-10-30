defmodule YoyakuWeb.Api.Types.Slots do
  use Absinthe.Schema.Notation
  import YoyakuWeb.Macros

  object :slot do
    field :id, non_null(:id)
    field :start_time, non_null(:datetime)
    field :end_time, non_null(:datetime)

    timestamps()
  end
end
