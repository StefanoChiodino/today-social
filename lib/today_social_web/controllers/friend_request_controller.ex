defmodule TodaySocialWeb.FriendRequestController do
  use TodaySocialWeb, :controller

  alias TodaySocial.Repo
  alias TodaySocial.Users.User
  alias TodaySocial.Friendship
  alias TodaySocial.Friendship.FriendRequest

  import Ecto.Query

  def index(conn, _params) do
    friend_requests = Repo.all((from fr in FriendRequest, where: fr.to_user_id == ^Pow.Plug.current_user(conn).id and fr.accepted == false and fr.rejected == false))
    render(conn, "index.html", friend_request: friend_requests)
  end

  def new(conn, _params) do
    changeset = Friendship.change_friend_request(%FriendRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  defp warn(conn), do: put_flash(conn, :info, "The user will receive an invite if they exist.")

  def create(conn, %{"friend_request" => friend_request_params}) do
    case Repo.get_by(User, email: friend_request_params["email_address"]) do
      nil -> conn |> warn
      user ->
        friend_request = %{
          from_user_id: Pow.Plug.current_user(conn).id,
          to_user_id: user.id,
        }
        Friendship.create_friend_request(friend_request)
        conn
        |> warn
        |> redirect(to: Routes.friend_request_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id}) do
      Repo.get_by(FriendRequest, [id: id, to_user_id: Pow.Plug.current_user(conn).id])
      |> Friendship.update_friend_request(%{accepted: true})

      redirect(conn, to: Routes.friend_request_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    Repo.get_by(FriendRequest, [id: id, to_user_id: Pow.Plug.current_user(conn).id])
    |> Friendship.update_friend_request(%{rejected: true})

    redirect(conn, to: Routes.friend_request_path(conn, :index))
  end

  # def show(conn, %{"id" => id}) do
  #   friend_request = Friendship.get_friend_request!(id)
  #   render(conn, "show.html", friend_request: friend_request)
  # end

  # def edit(conn, %{"id" => id}) do
  #   friend_request = Friendship.get_friend_request!(id)
  #   changeset = Friendship.change_friend_request(friend_request)
  #   render(conn, "edit.html", friend_request: friend_request, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "friend_request" => friend_request_params}) do
  #   friend_request = Friendship.get_friend_request!(id)

  #   case Friendship.update_friend_request(friend_request, friend_request_params) do
  #     {:ok, friend_request} ->
  #       conn
  #       |> put_flash(:info, "Friend request updated successfully.")
  #       |> redirect(to: Routes.friend_request_path(conn, :show, friend_request))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", friend_request: friend_request, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   friend_request = Friendship.get_friend_request!(id)
  #   {:ok, _friend_request} = Friendship.delete_friend_request(friend_request)

  #   conn
  #   |> put_flash(:info, "Friend request deleted successfully.")
  #   |> redirect(to: Routes.friend_request_path(conn, :index))
  # end
end
