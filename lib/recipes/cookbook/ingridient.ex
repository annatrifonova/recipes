defmodule Recipes.Cookbook.Ingridient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Recipes.Cookbook.Recipe

  schema "ingridients" do
    field(:name, :string)
    field(:quantity, :string)

    belongs_to(:recipe, Recipe)

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
