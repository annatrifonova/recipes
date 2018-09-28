defmodule Recipes.Cookbook.RecipeTest do
  use Recipes.DataCase

  alias Recipes.Cookbook
  alias Recipes.Cookbook.Recipe

  @valid_attrs %{description: "some description", instructions: "some instructions", name: "some name", time: 42}
  @update_attrs %{description: "some updated description", instructions: "some updated instructions", name: "some updated name", time: 43}
  @invalid_attrs %{description: nil, instructions: nil, name: nil, time: nil}

  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Cookbook.create_recipe()

    recipe
  end

  describe "list_recipes/0" do
    test "returns all recipes" do
      recipe = recipe_fixture()
      assert Cookbook.list_recipes() == [recipe]
    end
  end

  describe "get_recipe!/1" do
    test "returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Cookbook.get_recipe!(recipe.id) == recipe
    end
  end

  describe "create_recipe/1" do
    test "with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Cookbook.create_recipe(@valid_attrs)
      assert recipe.description == "some description"
      assert recipe.instructions == "some instructions"
      assert recipe.name == "some name"
      assert recipe.time == 42
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cookbook.create_recipe(@invalid_attrs)
    end
  end

  describe "update_recipe/2" do
    test "with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, recipe} = Cookbook.update_recipe(recipe, @update_attrs)
      assert %Recipe{} = recipe
      assert recipe.description == "some updated description"
      assert recipe.instructions == "some updated instructions"
      assert recipe.name == "some updated name"
      assert recipe.time == 43
    end

    test "with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Cookbook.update_recipe(recipe, @invalid_attrs)
      assert recipe == Cookbook.get_recipe!(recipe.id)
    end
  end

  describe "delete_recipe/1" do
    test "deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Cookbook.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Cookbook.get_recipe!(recipe.id) end
    end
  end

  describe "change_recipe/1" do
    test "returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Cookbook.change_recipe(recipe)
    end
  end
end
