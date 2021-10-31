defmodule YoyakuWeb.Api.Resolvers.UserResolvers do
  alias Yoyaku.Accounts

  def create_user(%{params: params}, _) do
    with {:ok, user} <- Accounts.register_user(params) do
      {:ok, %{success: true, data: user}}
    end
  end

  def current_user(_, %{context: %{current_user: user}}) do
    {:ok, user}
  end
end
