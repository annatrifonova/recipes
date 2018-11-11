defmodule RecipesWeb.RecipeControllerTest do
  use RecipesWeb.ConnCase

  import Recipes.Factory

  describe "index" do
    test "lists all recipes", %{conn: conn} do
      conn = get(conn, recipe_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Recipes"
    end

    test "lists all recipes with given name", %{conn: conn} do
      %{name: name} = insert(:recipe)
      %{name: other_name} = insert(:recipe)
      conn = get(conn, recipe_path(conn, :index, search: %{name: name}))

      assert response = html_response(conn, 200)
      assert response =~ "Listing Recipes"
      assert response =~ name
      refute response =~ other_name
    end

    test "lists recipes with partially matched name", %{conn: conn} do
      insert(:recipe, name: "foo bar baz")
      %{name: other_name} = insert(:recipe)
      conn = get(conn, recipe_path(conn, :index, search: %{name: "bar"}))

      assert response = html_response(conn, 200)
      assert response =~ "Listing Recipes"
      assert response =~ "foo bar baz"
      refute response =~ other_name
    end

    test "empty list if no recipes matching name", %{conn: conn} do
      insert(:recipe, name: "other recipe")
      conn = get(conn, recipe_path(conn, :index, search: %{name: "bar"}))

      assert response = html_response(conn, 200)
      assert response =~ "Listing Recipes"
      refute response =~ "other recipe"
    end
  end

  describe "new recipe" do
    test "renders form", %{conn: conn} do
      conn = get(conn, recipe_path(conn, :new))
      assert html_response(conn, 200) =~ "New Recipe"
    end
  end

  describe "create recipe" do
    test "redirects to show when data is valid", %{conn: conn} do
      %{name: name} = params = params_for(:recipe)
      conn = post(conn, recipe_path(conn, :create), recipe: params)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == recipe_path(conn, :show, id)

      conn = get(conn, recipe_path(conn, :show, id))
      assert html_response(conn, 200) =~ name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = params_for(:recipe, name: "")
      conn = post(conn, recipe_path(conn, :create), recipe: params)
      assert html_response(conn, 200) =~ "New Recipe"
    end
  end

  describe "edit recipe" do
    setup [:create_recipe]

    test "renders form for editing chosen recipe", %{conn: conn, recipe: recipe} do
      conn = get(conn, recipe_path(conn, :edit, recipe))
      assert html_response(conn, 200) =~ "Edit Recipe"
    end
  end

  describe "update recipe" do
    setup [:create_recipe]

    test "redirects when data is valid", %{conn: conn, recipe: recipe} do
      %{name: name, description: description, instructions: instructions, time: time} =
        params = params_for(:recipe)

      conn = put(conn, recipe_path(conn, :update, recipe), recipe: params)
      assert redirected_to(conn) == recipe_path(conn, :show, recipe)

      response =
        conn
        |> get(recipe_path(conn, :show, recipe))
        |> html_response(200)

      assert response =~ name
      assert response =~ description
      assert response =~ instructions
      assert response =~ Integer.to_string(time)
    end

    test "renders errors when data is invalid", %{conn: conn, recipe: recipe} do
      params = params_for(:recipe, name: "")
      conn = put(conn, recipe_path(conn, :update, recipe), recipe: params)
      assert html_response(conn, 200) =~ "Edit Recipe"
    end
  end

  describe "delete recipe" do
    setup [:create_recipe]

    test "deletes chosen recipe", %{conn: conn, recipe: recipe} do
      conn = delete(conn, recipe_path(conn, :delete, recipe))
      assert redirected_to(conn) == recipe_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, recipe_path(conn, :show, recipe))
      end)
    end
  end

  defp create_recipe(_) do
    recipe = insert(:recipe)
    {:ok, recipe: recipe}
  end
end
