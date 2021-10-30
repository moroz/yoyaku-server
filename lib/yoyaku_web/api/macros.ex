defmodule YoyakuWeb.Macros do
  use Absinthe.Schema.Notation

  defmacro timestamps do
    quote do
      field :inserted_at, non_null(:datetime)
      field :updated_at, non_null(:datetime)
    end
  end
end
