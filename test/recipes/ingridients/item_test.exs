defmodule Recipes.Ingridients.ItemTest do
  use Recipes.DataCase

  import Recipes.Factory

  alias Recipes.Ingridients
  alias Recipes.Ingridients.Item

  describe "list_ingridients/1" do
    test "returns all ingridients for the specified recipe" do
      ingridient = insert(:ingridient)
      %{id: ingridient_id, recipe: recipe} = ingridient
      %{id: recipe_id} = recipe

      # Same as:
      # %{id: ingridient_id, recipe: %{id: recipe_id} = recipe} = insert(:ingridient)

      assert [
               %Item{
                 id: ^ingridient_id,
                 recipe_id: ^recipe_id
               }
             ] = Ingridients.list_ingridients(recipe)
    end
  end

  describe "create_ingridient/1" do
    test "creates a new ingridient with valid attributes" do
      %{id: recipe_id} = insert(:recipe)
      %{name: name, quantity: quantity} = params = params_for(:ingridient, recipe_id: recipe_id)

      assert {:ok, %Item{} = ingridient} = Ingridients.create_ingridient(params)

      assert %{
               name: ^name,
               quantity: ^quantity,
               recipe_id: ^recipe_id
             } = ingridient
    end

    test "returns error changeset with invalid attributes" do
      %{id: recipe_id} = insert(:recipe)
      params = params_for(:ingridient, recipe_id: recipe_id, name: "")
      assert {:error, %Ecto.Changeset{}} = Ingridients.create_ingridient(params)
    end
  end
end
