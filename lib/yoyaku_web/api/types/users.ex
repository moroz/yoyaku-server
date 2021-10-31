defmodule YoyakuWeb.Api.Types.Users do
  use Absinthe.Schema.Notation
  alias YoyakuWeb.Api.Resolvers.UserResolvers

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
  end

  input_object :user_params do
    field :email, :string
    field :password, :string
  end

  object :user_mutation_result do
    field :success, non_null(:boolean)
    field :errors, :json
    field :data, :user
  end

  object :user_mutations do
    field :create_user, non_null(:user_mutation_result) do
      arg(:params, non_null(:user_params))
      resolve(&UserResolvers.create_user/2)
    end
  end
end
