defmodule RecipesWeb.IngridientController do
  use RecipesWeb, :controller

  alias Recipes.Cookbook
  alias Recipes.Cookbook.Ingridient

  def new(conn, %{"recipe_id" => recipe_id}) do
    recipe = Cookbook.get_recipe!(recipe_id)
    changeset = Cookbook.change_ingridient(%Ingridient{})
    render(conn, "new.html", recipe: recipe, changeset: changeset)
  end

  def create(conn, %{"recipe_id" => recipe_id, "ingridient" => ingridient_params}) do
    recipe = Cookbook.get_recipe!(recipe_id)
    params = Map.put(ingridient_params, "recipe_id", recipe_id)

    case Cookbook.create_ingridient(params) do
      {:ok, _ingridient} ->
        conn
        |> put_flash(:info, "Ingridient created successfully.")
        |> redirect(to: recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", recipe: recipe, changeset: changeset)
    end
  end

  def edit(conn, %{"recipe_id" => recipe_id, "id" => id}) do
    recipe = Cookbook.get_recipe!(recipe_id)
    ingridient = Cookbook.get_ingridient!(id)
    changeset = Cookbook.change_ingridient(ingridient)
    render(conn, "edit.html", recipe: recipe, ingridient: ingridient, changeset: changeset)
  end

  def update(conn, %{"recipe_id" => recipe_id, "id" => id, "ingridient" => ingridient_params}) do
    recipe = Cookbook.get_recipe!(recipe_id)
    ingridient = Cookbook.get_ingridient!(id)

    case Cookbook.update_ingridient(ingridient, ingridient_params) do
      {:ok, _ingridient} ->
        conn
        |> put_flash(:info, "Ingridient updated successfully.")
        |> redirect(to: recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", recipe: recipe, ingridient: ingridient, changeset: changeset)
    end
  end

  def delete(conn, %{"recipe_id" => recipe_id, "id" => id}) do
    recipe = Cookbook.get_recipe!(recipe_id)
    ingridient = Cookbook.get_ingridient!(id)

    {:ok, _ingridient} = Cookbook.delete_ingridient(ingridient)

    conn
    |> put_flash(:info, "Ingridient deleted successfully.")
    |> redirect(to: recipe_path(conn, :show, recipe))
  end
end
