defmodule Recipes.Repo.Migrations.AddProductReferenceToIngridients do
  use Ecto.Migration

  def change do
    alter table(:ingridients) do
      add :product_id, references(:products, on_delete: :restrict)
    end
  end
end
