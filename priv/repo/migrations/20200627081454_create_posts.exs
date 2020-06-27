defmodule TodaySocial.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, :integer
      add :yesterday, :string
      add :today, :string

      timestamps()
    end

  end
end
