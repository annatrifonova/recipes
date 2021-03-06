defmodule Recipes.Cookbook.RecipeTest do
  use Recipes.DataCase

  import Recipes.Factory

  alias Recipes.Cookbook
  alias Recipes.Cookbook.Recipe

  describe "list_recipes/1" do
    test "returns all recipes" do
      recipe = insert(:recipe)
      assert Cookbook.list_recipes(%{}) == [recipe]
    end

    test "returns recipes with the given name" do
      %{name: name} = recipe = insert(:recipe)
      assert Cookbook.list_recipes(%{name: name}) == [recipe]
    end

    test "returns recipes with partially matched name" do
      recipe = insert(:recipe, name: "foo bar baz")
      assert Cookbook.list_recipes(%{name: "bar"}) == [recipe]
    end

    test "returns empty list if nothing found" do
      insert(:recipe, name: "recipe")
      assert Cookbook.list_recipes(%{name: "bar"}) == []
    end

    test "returns recipes with given product" do
      %{product: product, recipe: recipe} = insert(:ingridient)
      %{name: product_name} = product
      assert Cookbook.list_recipes(%{product: product_name}) == [recipe]
    end

    test "returns empty list if there's no recipe with given product" do
      insert(:recipe)
      %{name: product_name} = insert(:product)
      assert Cookbook.list_recipes(%{product: product_name}) == []
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
      %{name: name, description: description, instructions: instructions, time: time} =
        params = params_for(:recipe)

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

      %{name: name, description: description, instructions: instructions, time: time} =
        params = params_for(:recipe)

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
