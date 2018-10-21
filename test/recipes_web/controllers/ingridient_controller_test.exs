defmodule RecipesWeb.IngridientControllerTest do
  use RecipesWeb.ConnCase

  import Recipes.Factory

  setup [:create_recipe]

  describe "new ingridient" do
    test "renders form", %{conn: conn, recipe: recipe} do
      conn = get(conn, recipe_ingridient_path(conn, :new, recipe))
      assert html_response(conn, 200) =~ "New Ingridient" 
    end
  end

  describe "create ingridient" do
    test "redirects to show recipe when data is valid", %{conn: conn, recipe: recipe} do
      %{name: name} = params = params_for(:ingridient)
      conn = post(conn, recipe_ingridient_path(conn, :create, recipe), ingridient: params)

      assert redirected_to(conn) == recipe_path(conn, :show, recipe)

      conn = get(conn, recipe_path(conn, :show, recipe))
      assert html_response(conn, 200) =~ name
    end

    test "renders form when data is invalid", %{conn: conn, recipe: recipe} do
      params = params_for(:ingridient, name: "")
      conn = post(conn, recipe_ingridient_path(conn, :create, recipe), ingridient: params)
      assert html_response(conn, 200) =~ "New Ingridient"
    end
  end

  defp create_recipe(_) do
    recipe = insert(:recipe)
    {:ok, recipe: recipe}
  end
end