defmodule YoyakuWeb.UserSessionControllerTest do
  use YoyakuWeb.ConnCase, async: true

  setup do
    %{user: insert(:user)}
  end

  describe "POST /users/log_in" do
    test "logs the user in", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.user_session_path(conn, :create), %{
          "email" => user.email,
          "password" => valid_user_password()
        })

      assert get_session(conn, :user_token)
      assert %{"status" => "OK"} = json_response(conn, 200)
    end

    test "logs the user in with remember me", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.user_session_path(conn, :create), %{
          "email" => user.email,
          "password" => valid_user_password(),
          "remember_me" => "true"
        })

      assert conn.resp_cookies["_yoyaku_web_user_remember_me"]
      assert %{"status" => "OK"} = json_response(conn, 200)
    end

    test "emits error message with invalid credentials", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.user_session_path(conn, :create), %{
          "email" => user.email,
          "password" => "invalid_password"
        })

      response = json_response(conn, 401)
      assert %{"error" => error} = response
      assert error =~ "Invalid email or password"
    end
  end

  describe "DELETE /users/log_out" do
    test "logs the user out", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> delete(Routes.user_session_path(conn, :delete))
      assert response(conn, 204)
      refute get_session(conn, :user_token)
    end

    test "succeeds even if the user is not logged in", %{conn: conn} do
      conn = delete(conn, Routes.user_session_path(conn, :delete))
      assert response(conn, 204)
      refute get_session(conn, :user_token)
    end
  end
end
