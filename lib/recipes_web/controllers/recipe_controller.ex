defmodule RecipesWeb.RecipeController do
  use RecipesWeb, :controller

  alias Recipes.Cookbook
  alias Recipes.Cookbook.Recipe

  def index(conn, _params) do
    recipes = Cookbook.list_recipes()
    render(conn, "index.html", recipes: recipes)
  end

  def new(conn, _params) do
    changeset = Cookbook.change_recipe(%Recipe{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    case Cookbook.create_recipe(recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Cookbook.get_recipe!(id)
    ingridients = Cookbook.list_ingridients(recipe)
    render(conn, "show.html", recipe: recipe, ingridients: ingridients)
  end

  def edit(conn, %{"id" => id}) do
    recipe = Cookbook.get_recipe!(id)
    changeset = Cookbook.change_recipe(recipe)
    render(conn, "edit.html", recipe: recipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Cookbook.get_recipe!(id)

    case Cookbook.update_recipe(recipe, recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe updated successfully.")
        |> redirect(to: recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", recipe: recipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Cookbook.get_recipe!(id)
    {:ok, _recipe} = Cookbook.delete_recipe(recipe)

    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: recipe_path(conn, :index))
  end
end
