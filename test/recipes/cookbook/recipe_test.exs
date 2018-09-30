defmodule Recipes.Cookbook.RecipeTest do
  use Recipes.DataCase

  import Recipes.Factory

  alias Recipes.Cookbook
  alias Recipes.Cookbook.Recipe

  describe "list_recipes/0" do
    test "returns all recipes" do
      recipe = insert(:recipe)
      assert Cookbook.list_recipes() == [recipe]
    end
  end

  describe "get_recipe!/1" do
    test "returns the recipe with given id" do
      recipe = insert(:recipe)
      assert Cookbook.get_recipe!(recipe.id) == recipe
    end
  end

  describe "create_recipe/1" do
    test "with valid data creates a recipe" do
      %{name: name, description: description, instructions: instructions, time: time} = params = params_for(:recipe)

      assert {:ok, %Recipe{} = recipe} = Cookbook.create_recipe(params)
      assert %{
        name: ^name,
        description: ^description,
        instructions: ^instructions,
        time: ^time
      } = recipe
    end

    test "with invalid data returns error changeset" do
      params = params_for(:recipe, name: "")
      assert {:error, %Ecto.Changeset{}} = Cookbook.create_recipe(params)
    end
  end

  describe "update_recipe/2" do
    test "with valid data updates the recipe" do
      recipe = insert(:recipe)
      %{name: name, description: description, instructions: instructions, time: time} = params = params_for(:recipe)

      assert {:ok, recipe} = Cookbook.update_recipe(recipe, params)

      assert %{
        name: ^name,
        description: ^description,
        instructions: ^instructions,
        time: ^time
      } = recipe
    end

    test "with invalid data returns error changeset" do
      recipe = insert(:recipe)
      params = params_for(:recipe, name: "")
      assert {:error, %Ecto.Changeset{}} = Cookbook.update_recipe(recipe, params)
      assert recipe == Cookbook.get_recipe!(recipe.id)
    end
  end

  describe "delete_recipe/1" do
    test "deletes the recipe" do
      recipe = insert(:recipe)
      assert {:ok, %Recipe{}} = Cookbook.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Cookbook.get_recipe!(recipe.id) end
    end
  end

  describe "change_recipe/1" do
    test "returns a recipe changeset" do
      recipe = insert(:recipe)
      assert %Ecto.Changeset{} = Cookbook.change_recipe(recipe)
    end
  end
end
