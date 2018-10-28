defmodule Recipes.Repo.Migrations.RemoveNameFromIngridients do
  use Ecto.Migration

  def change do
    alter table(:ingridients) do
      remove :name
    end
  end
end
