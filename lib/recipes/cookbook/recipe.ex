defmodule Recipes.Cookbook.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Recipes.Ingridients

  schema "recipes" do
    field(:description, :string)
    field(:instructions, :string)
    field(:name, :string)
    field(:time, :integer)

    has_many(:ingridients, Ingridients.Item, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :description, :instructions, :time])
    |> validate_required([:name, :instructions, :time])
  end
end
