defmodule Recipes.Ingridients do
  import Ecto.Query, warn: false

  alias Recipes.Repo
  alias Recipes.Cookbook.Recipe
  alias Recipes.Ingridients.Item

  def list_ingridients(%Recipe{id: recipe_id}) do
    Repo.all(from(Item, where: [recipe_id: ^recipe_id]))
  end

  def create_ingridient(attr) do
    %Item{}
    |> Item.changeset(attr)
    |> Repo.insert()
  end

  def update_ingridient(ingridient, attr) do
    ingridient
    |> Item.changeset(attr)
    |> Repo.update()
  end

  def delete_ingridient(ingridient) do
    Repo.delete(ingridient)
  end
end
