defmodule Recipes.Cookbook.Ingridient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Recipes.Cookbook.{Recipe, Product}

  schema "ingridients" do
    field(:quantity, :string)

    belongs_to(:recipe, Recipe)
    belongs_to(:product, Product)

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :quantity, :recipe_id])
    |> validate_required([:name, :quantity, :recipe_id])
    |> foreign_key_constraint(:recipe_id)
  end
end
