defmodule Recipes.Repo.Migrations.MakeIngridientsItems do
  use Ecto.Migration

  def change do
    create table(:ingridients_items) do
      add :name, :string
      add :quantity, :string

      add :recipe_id, references(:recipes, on_delete: :delete_all)

      timestamps()
    end
  end
end
