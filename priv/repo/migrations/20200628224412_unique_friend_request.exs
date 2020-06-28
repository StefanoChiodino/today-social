defmodule TodaySocial.Repo.Migrations.UniqueFriendRequest do
  use Ecto.Migration

  def change do
    create unique_index(:friend_request, [:from_user_id, :to_user_id])
  end
end
