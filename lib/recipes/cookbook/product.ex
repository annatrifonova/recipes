defmodule Recipes.Cookbook.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Recipes.Cookbook.Ingridient

  schema "products" do
    field(:name, :string)

    has_many(:ingridients, Ingridient, on_delete: :nothing)

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
