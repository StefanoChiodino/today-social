defmodule TodaySocial.FriendshipTest do
  use TodaySocial.DataCase

  alias TodaySocial.Friendship

  describe "friend_request" do
    alias TodaySocial.Friendship.FriendRequest

    @valid_attrs %{accepted: true, from_user_id: 42, to_user_id: 42}
    @update_attrs %{accepted: false, from_user_id: 43, to_user_id: 43}
    @invalid_attrs %{accepted: nil, from_user_id: nil, to_user_id: nil}

    def friend_request_fixture(attrs \\ %{}) do
      {:ok, friend_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Friendship.create_friend_request()

      friend_request
    end

    test "list_friend_request/0 returns all friend_request" do
      friend_request = friend_request_fixture()
      assert Friendship.list_friend_request() == [friend_request]
    end

    test "get_friend_request!/1 returns the friend_request with given id" do
      friend_request = friend_request_fixture()
      assert Friendship.get_friend_request!(friend_request.id) == friend_request
    end

    test "create_friend_request/1 with valid data creates a friend_request" do
      assert {:ok, %FriendRequest{} = friend_request} = Friendship.create_friend_request(@valid_attrs)
      assert friend_request.accepted == true
      assert friend_request.from_user_id == 42
      assert friend_request.to_user_id == 42
    end

    test "create_friend_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friendship.create_friend_request(@invalid_attrs)
    end

    test "update_friend_request/2 with valid data updates the friend_request" do
      friend_request = friend_request_fixture()
      assert {:ok, %FriendRequest{} = friend_request} = Friendship.update_friend_request(friend_request, @update_attrs)
      assert friend_request.accepted == false
      assert friend_request.from_user_id == 43
      assert friend_request.to_user_id == 43
    end

    test "update_friend_request/2 with invalid data returns error changeset" do
      friend_request = friend_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Friendship.update_friend_request(friend_request, @invalid_attrs)
      assert friend_request == Friendship.get_friend_request!(friend_request.id)
    end

    test "delete_friend_request/1 deletes the friend_request" do
      friend_request = friend_request_fixture()
      assert {:ok, %FriendRequest{}} = Friendship.delete_friend_request(friend_request)
      assert_raise Ecto.NoResultsError, fn -> Friendship.get_friend_request!(friend_request.id) end
    end

    test "change_friend_request/1 returns a friend_request changeset" do
      friend_request = friend_request_fixture()
      assert %Ecto.Changeset{} = Friendship.change_friend_request(friend_request)
    end
  end
end
