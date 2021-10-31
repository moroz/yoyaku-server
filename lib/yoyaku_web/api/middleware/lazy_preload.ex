defmodule YoyakuWeb.Api.Middleware.LazyPreload do
  @moduledoc """
  Absinthe middleware to preload Ecto associations only if they have
  been requested.
  """

  require Absinthe.Schema.Notation

  defmacro lazy_preload(assoc_name) do
    quote do
      middleware(unquote(__MODULE__), unquote(assoc_name))
    end
  end

  @behaviour Absinthe.Middleware

  alias Yoyaku.Repo

  def init(_), do: nil

  def call(%{source: source} = res, assoc_name) when is_atom(assoc_name) do
    value =
      case Map.get(source, assoc_name) do
        %Ecto.Association.NotLoaded{__cardinality__: :one} ->
          Repo.one(Ecto.assoc(source, assoc_name))

        %Ecto.Association.NotLoaded{} ->
          Repo.all(Ecto.assoc(source, assoc_name))

        nil ->
          nil

        %_module{} = struct ->
          struct

        list when is_list(list) ->
          list
      end

    %{res | value: value, state: :resolved}
  end

  def call(%{source: source} = res, [{assoc_name, _}] = list) do
    preloaded = Repo.preload(source, list)
    value = Map.get(preloaded, assoc_name)
    %{res | value: value, state: :resolved}
  end
end
