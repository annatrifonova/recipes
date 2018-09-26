defmodule Recipes.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :description, :string
      add :instructions, :string
      add :time, :integer

      timestamps()
    end

  end
end
