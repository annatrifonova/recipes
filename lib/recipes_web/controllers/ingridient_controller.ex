defmodule RecipesWeb.IngridientController do
  use RecipesWeb, :controller

  alias Recipes.Cookbook
  alias Recipes.Cookbook.{Recipe, Ingridient}

  def new(conn, %{"recipe_id" => recipe_id}) do
    recipe = Cookbook.get_recipe!(recipe_id)
    changeset = Cookbook.change_ingridient(%Ingridient{})
    render(conn, "new.html", recipe: recipe, changeset: changeset)
  end

  def create(conn, %{"recipe_id" => recipe_id, "ingridient" => ingridient_params}) do
    recipe = Cookbook.get_recipe!(recipe_id)
    params = Map.put(ingridient_params, "recipe_id", recipe_id)

    case Cookbook.create_ingridient(params) do
      {:ok, ingridient} ->
        conn
        |> put_flash(:info, "Ingridient created successfully.")
        |> redirect(to: recipe_path(conn, :show, recipe))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", recipe: recipe, changeset: changeset)
    end
  end
end
