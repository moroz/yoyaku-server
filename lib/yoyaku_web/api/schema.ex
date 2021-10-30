defmodule YoyakuWeb.Api.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(YoyakuWeb.Api.Types.Slots)
  import_types(YoyakuWeb.Api.Types.JSON)

  query do
    import_fields(:slot_queries)
  end

  mutation do
    import_fields(:slot_mutations)
  end

  def middleware(middleware, _field, %Absinthe.Type.Object{identifier: :mutation}) do
    middleware ++ [YoyakuWeb.Api.Middleware.TransformErrors]
  end

  def middleware(middleware, _, _) do
    middleware
  end
end
