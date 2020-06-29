defmodule TodaySocial.Repo.Migrations.AddRejectedToFriendshipRequest do
  use Ecto.Migration

  def change do
    alter table(:friend_request) do
      add :rejected, :boolean
    end
  end
end
