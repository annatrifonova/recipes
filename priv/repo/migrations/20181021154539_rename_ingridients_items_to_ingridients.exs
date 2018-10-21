defmodule Recipes.Repo.Migrations.RenameIngridientsItemsToIngridients do
  use Ecto.Migration

  def change do
    rename table(:ingridients_items), to: table(:ingridients)
  end
end
