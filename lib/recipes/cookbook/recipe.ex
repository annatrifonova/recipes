defmodule Recipes.Cookbook.Recipe do
  use Ecto.Schema
  import Ecto.Changeset


  schema "recipes" do
    field :description, :string
    field :instructions, :string
    field :name, :string
    field :time, :integer

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :description, :instructions, :time])
    |> validate_required([:name, :instructions, :time])
  end
end
