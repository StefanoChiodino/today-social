defmodule TodaySocialWeb.PostController do
  use TodaySocialWeb, :controller
  require Logger

  alias TodaySocial.Repo
  alias TodaySocial.Journal
  alias TodaySocial.Journal.Post
  alias TodaySocial.Friendship.FriendRequest
  alias TodaySocial.Users.User

  import Ecto.Query

  def index(conn, _params) do
    user_id = Pow.Plug.current_user(conn).id
    accepted_friend_requests = Repo.all((from fr in FriendRequest, where: (fr.to_user_id == ^user_id or fr.from_user_id == ^user_id) and fr.accepted == true))
    friend_user_ids = Enum.map(accepted_friend_requests, &(if &1.from_user_id == user_id, do: &1.to_user_id, else: &1.from_user_id))
    username_and_posts = Repo.all((from p in Post,
      where: p.user_id == ^user_id or p.user_id in ^friend_user_ids,
      join: u in User,
      on: u.id == p.user_id,
      select: {u.username, p}))
    render(conn, "index.html", username_and_posts: username_and_posts)
  end

  def new(conn, _params) do
    changeset = Journal.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Journal.create_post(Map.put(post_params, "user_id", Pow.Plug.current_user(conn).id)) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Journal.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Journal.get_post!(id)
    changeset = Journal.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Journal.get_post!(id)

    case Journal.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Journal.get_post!(id)
    {:ok, _post} = Journal.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
