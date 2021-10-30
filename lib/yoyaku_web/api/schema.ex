defmodule YoyakuWeb.Api.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(YoyakuWeb.Api.Types.Slots)

  query do
    field :hello, non_null(:string) do
      resolve(fn _, _ -> {:ok, "Hello world!"} end)
    end
  end
end
