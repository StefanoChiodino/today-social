defmodule TodaySocial.Repo.Migrations.CreateFriendRequest do
  use Ecto.Migration

  def change do
    create table(:friend_request) do
      add :from_user_id, :integer
      add :to_user_id, :integer
      add :accepted, :boolean, default: false, null: false

      timestamps()
    end

  end
end
