defmodule TodaySocialWeb.FriendRequestControllerTest do
  use TodaySocialWeb.ConnCase

  alias TodaySocial.Friendship

  @create_attrs %{accepted: true, from_user_id: 42, to_user_id: 42}
  @update_attrs %{accepted: false, from_user_id: 43, to_user_id: 43}
  @invalid_attrs %{accepted: nil, from_user_id: nil, to_user_id: nil}

  def fixture(:friend_request) do
    {:ok, friend_request} = Friendship.create_friend_request(@create_attrs)
    friend_request
  end

  describe "index" do
    test "lists all friend_request", %{conn: conn} do
      conn = get(conn, Routes.friend_request_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Friend request"
    end
  end

  describe "new friend_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.friend_request_path(conn, :new))
      assert html_response(conn, 200) =~ "New Friend request"
    end
  end

  describe "create friend_request" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.friend_request_path(conn, :create), friend_request: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.friend_request_path(conn, :show, id)

      conn = get(conn, Routes.friend_request_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Friend request"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.friend_request_path(conn, :create), friend_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Friend request"
    end
  end

  describe "edit friend_request" do
    setup [:create_friend_request]

    test "renders form for editing chosen friend_request", %{conn: conn, friend_request: friend_request} do
      conn = get(conn, Routes.friend_request_path(conn, :edit, friend_request))
      assert html_response(conn, 200) =~ "Edit Friend request"
    end
  end

  describe "update friend_request" do
    setup [:create_friend_request]

    test "redirects when data is valid", %{conn: conn, friend_request: friend_request} do
      conn = put(conn, Routes.friend_request_path(conn, :update, friend_request), friend_request: @update_attrs)
      assert redirected_to(conn) == Routes.friend_request_path(conn, :show, friend_request)

      conn = get(conn, Routes.friend_request_path(conn, :show, friend_request))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, friend_request: friend_request} do
      conn = put(conn, Routes.friend_request_path(conn, :update, friend_request), friend_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Friend request"
    end
  end

  describe "delete friend_request" do
    setup [:create_friend_request]

    test "deletes chosen friend_request", %{conn: conn, friend_request: friend_request} do
      conn = delete(conn, Routes.friend_request_path(conn, :delete, friend_request))
      assert redirected_to(conn) == Routes.friend_request_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.friend_request_path(conn, :show, friend_request))
      end
    end
  end

  defp create_friend_request(_) do
    friend_request = fixture(:friend_request)
    %{friend_request: friend_request}
  end
end
