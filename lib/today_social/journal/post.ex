defmodule TodaySocial.Journal.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :user_id, :integer
    field :yesterday, :string
    field :today, :string


    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user_id, :today, :yesterday])
    |> validate_required([:user_id, :yesterday, :today])
    |> validate_length(:yesterday, min: 3)
    |> validate_length(:today, min: 3)
  end
end
