defmodule TodaySocialWeb.FriendshipHelpers do
  use TodaySocialWeb, :controller

  alias TodaySocial.Repo
  alias TodaySocial.Friendship.FriendRequest

  def init(default), do: default

  def call(conn, _default) do
    case Pow.Plug.current_user(conn) do
      nil -> conn
      user -> case Repo.aggregate(FriendRequest, :count, [to_user_id: user.id, accepted: false, rejected: false]) do
          0 -> conn
          friend_request_count -> conn
          |> put_flash(:info, "You have #{friend_request_count} friend request(s)!")
          |> put_flash(:friend_request_count, friend_request_count)
        end
    end
  end
end
