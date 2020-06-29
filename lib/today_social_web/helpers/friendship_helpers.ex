defmodule TodaySocialWeb.FriendshipHelpers do
  use TodaySocialWeb, :controller

  alias TodaySocial.Repo
  alias TodaySocial.Friendship.FriendRequest

  def init(default), do: default

  def call(conn, _default) do
    case Pow.Plug.current_user(conn) do
      nil -> conn
      user ->
      case Repo.get_by(FriendRequest, [to_user_id: user.id, accepted: false]) do
        nil -> conn
        _friend_requests -> conn |> put_flash(:info, "You have friend requests!")
      end
    end
  end
end
