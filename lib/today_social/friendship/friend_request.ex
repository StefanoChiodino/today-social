defmodule TodaySocial.Friendship.FriendRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friend_request" do
    field :accepted, :boolean, default: false
    field :rejected, :boolean, default: false
    field :from_user_id, :integer
    field :to_user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(friend_request, attrs) do
    friend_request
    |> cast(attrs, [:from_user_id, :to_user_id, :accepted, :rejected])
    |> validate_required([:from_user_id, :to_user_id])
    |> unique_constraint([:from_user_id, :to_user_id])
  end
end
