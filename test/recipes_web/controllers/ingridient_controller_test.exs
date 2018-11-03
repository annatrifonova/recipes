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
      %{name: name} = insert(:product)
      %{quantity: quantity} = params_for(:ingridient)

      params = %{
        name: name,
        quantity: quantity
      }

      conn = post(conn, recipe_ingridient_path(conn, :create, recipe), ingridient: params)

      assert redirected_to(conn) == recipe_path(conn, :show, recipe)

      conn = get(conn, recipe_path(conn, :show, recipe))
      assert html_response(conn, 200) =~ name
    end

    test "renders form when data is invalid", %{conn: conn, recipe: recipe} do
      params = %{
        name: "",
        quantity: ""
      }

      conn = post(conn, recipe_ingridient_path(conn, :create, recipe), ingridient: params)
      assert html_response(conn, 200) =~ "New Ingridient"
    end
  end

  describe "edit ingridient" do
    setup [:create_ingridient]

    test "renders form for editing chosen ingridient", %{
      conn: conn,
      recipe: recipe,
      ingridient: ingridient
    } do
      conn = get(conn, recipe_ingridient_path(conn, :edit, recipe, ingridient))
      assert html_response(conn, 200) =~ "Edit Ingridient"
    end
  end

  describe "update ingridient" do
    setup [:create_ingridient]

    test "redirects when data is valid", %{conn: conn, recipe: recipe, ingridient: ingridient} do
      %{name: name} = insert(:product)
      %{quantity: quantity} = params_for(:ingridient)

      params = %{
        name: name,
        quantity: quantity
      }

      conn =
        put(conn, recipe_ingridient_path(conn, :update, recipe, ingridient), ingridient: params)

      assert redirected_to(conn) == recipe_path(conn, :show, recipe)

      response =
        conn
        |> get(recipe_path(conn, :show, recipe))
        |> html_response(200)

      assert response =~ name
      assert response =~ quantity
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      recipe: recipe,
      ingridient: ingridient
    } do
      params = %{
        name: "",
        quantity: ""
      }

      conn =
        put(conn, recipe_ingridient_path(conn, :update, recipe, ingridient), ingridient: params)

      assert html_response(conn, 200) =~ "Edit Ingridient"
    end
  end

  describe "delete ingridient" do
    setup [:create_ingridient]

    test "deletes chosen ingridient", %{conn: conn, recipe: recipe, ingridient: ingridient} do
      conn = delete(conn, recipe_ingridient_path(conn, :delete, recipe, ingridient))
      assert redirected_to(conn) == recipe_path(conn, :show, recipe)

      assert_error_sent(404, fn ->
        get(conn, recipe_ingridient_path(conn, :edit, recipe, ingridient))
      end)
    end
  end

  defp create_recipe(_) do
    recipe = insert(:recipe)
    {:ok, recipe: recipe}
  end

  defp create_ingridient(%{recipe: recipe}) do
    ingridient = insert(:ingridient, recipe: recipe)
    {:ok, ingridient: ingridient}
  end
end
