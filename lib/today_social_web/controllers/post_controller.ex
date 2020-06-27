defmodule TodaySocialWeb.PostController do
  use TodaySocialWeb, :controller
  require Logger

  alias TodaySocial.Journal
  alias TodaySocial.Journal.Post

  def index(conn, _params) do
    posts = Journal.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Journal.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    # inspect = Map.put(post_params, "user_id", Pow.Plug.current_user(conn).id)
    # Logger.debug "INSPECT THIS #{inspect(inspect)}"
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