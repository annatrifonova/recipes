defmodule Recipes.Cookbook.Ingridient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Recipes.Cookbook.{Recipe, Product}

  schema "ingridients" do
    field(:quantity, :string)
    field(:name, :string, virtual: true)

    belongs_to(:recipe, Recipe)
    belongs_to(:product, Product)

    timestamps()
  end

  @doc false
  def changeset(ingridient, attrs) do
    ingridient
    |> cast(attrs, [:quantity, :name, :recipe_id, :product_id])
    |> validate_required([:quantity, :recipe_id, :product_id])
    |> foreign_key_constraint(:recipe_id)
    |> foreign_key_constraint(:product_id)
  end

  def put_product(ingridient, %Product{id: product_id}) do
    cast(ingridient, %{product_id: product_id}, [:product_id])
  end
end
