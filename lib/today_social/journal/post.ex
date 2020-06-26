defmodule TodaySocial.Journal.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user_id, :body])
    |> validate_required([:user_id, :body])
    |> validate_length(:body, min: 3)
  end
end
