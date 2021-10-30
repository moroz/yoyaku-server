defmodule YoyakuWeb.UserSessionController do
  use YoyakuWeb, :controller

  alias Yoyaku.Accounts
  alias YoyakuWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> UserAuth.log_in_user(user, user_params)
      |> send_resp(201, "OK")
    else
      conn
      |> put_status(401)
      |> json(%{error: "Invalid email or password"})
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
