defmodule Recipes.Cookbook.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Recipes.Cookbook.Ingridient

  schema "products" do
    field(:name, :string)

    has_many(:ingridients, Ingridient, on_delete: :nothing)
    
    timestamps()
  end
end