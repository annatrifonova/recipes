defmodule Recipes.Cookbook.IngridientTest do
  use Recipes.DataCase

  import Recipes.Factory

  alias Recipes.Cookbook
  alias Recipes.Cookbook.{Ingridient, Product}

  describe "list_ingridients/1" do
    test "returns all ingridients for the specified recipe" do
      ingridient = insert(:ingridient)
      %{id: ingridient_id, product_id: product_id, recipe: recipe} = ingridient
      %{id: recipe_id} = recipe

      assert [
               %Ingridient{
                 id: ^ingridient_id,
                 product_id: ^product_id,
                 recipe_id: ^recipe_id
               }
             ] = Cookbook.list_ingridients(recipe)
    end
  end

  describe "get_ingridient!/1" do
    test "returns the ingridient with given id" do
      %{id: id, recipe_id: recipe_id, product_id: product_id, quantity: quantity} =
        insert(:ingridient)

      assert %Ingridient{
               id: ^id,
               recipe_id: ^recipe_id,
               product_id: ^product_id,
               quantity: ^quantity
             } = Cookbook.get_ingridient!(id)
    end
  end

  describe "create_ingridient/1" do
    test "creates a new ingridient using the existing product" do
      %{id: recipe_id} = insert(:recipe)
      %{id: product_id, name: name} = insert(:product)
      %{quantity: quantity} = params_for(:ingridient)

      assert {:ok, %Ingridient{} = ingridient} =
               Cookbook.create_ingridient(%{
                 name: name,
                 quantity: quantity,
                 recipe_id: recipe_id
               })

      assert %{
               quantity: ^quantity,
               recipe_id: ^recipe_id,
               product_id: ^product_id
             } = ingridient
    end

    test "creates a new ingridient and new product" do
      %{id: recipe_id} = insert(:recipe)
      %{name: name} = params_for(:product)
      %{quantity: quantity} = params_for(:ingridient)

      params = %{
        name: name,
        quantity: quantity,
        recipe_id: recipe_id
      }

      assert {:ok, %Ingridient{} = ingridient} = Cookbook.create_ingridient(params)

      assert %{
               quantity: ^quantity,
               recipe_id: ^recipe_id,
               product_id: product_id
             } = ingridient

      assert %Product{id: ^product_id} = Cookbook.find_product(%{name: name})
    end

    test "returns error changeset with invalid attributes" do
      %{id: recipe_id} = insert(:recipe)

      params = %{
        name: "",
        quantity: "",
        recipe_id: recipe_id
      }

      assert {:error, %Ecto.Changeset{}} = Cookbook.create_ingridient(params)
    end
  end

  describe "update_ingridient/2" do
    test "update the ingridient using existing product" do
      %{id: ingridient_id, recipe_id: recipe_id} = ingridient = insert(:ingridient)
      %{id: product_id, name: name} = insert(:product)
      %{quantity: quantity} = params_for(:ingridient)

      params = %{
        name: name,
        quantity: quantity,
        recipe_id: recipe_id
      }

      assert {:ok, updated_ingridient} = Cookbook.update_ingridient(ingridient, params)

      assert %Ingridient{
               id: ^ingridient_id,
               recipe_id: ^recipe_id,
               product_id: ^product_id,
               quantity: ^quantity
             } = updated_ingridient
    end

    test "updates the ingridient and creates a new product" do
      %{id: ingridient_id, recipe_id: recipe_id} = ingridient = insert(:ingridient)
      %{name: name} = params_for(:product)
      %{quantity: quantity} = params_for(:ingridient)

      params = %{
        name: name,
        quantity: quantity,
        recipe_id: recipe_id
      }

      assert {:ok, updated_ingridient} = Cookbook.update_ingridient(ingridient, params)

      assert %Ingridient{
               id: ^ingridient_id,
               recipe_id: ^recipe_id,
               product_id: product_id,
               quantity: ^quantity
             } = updated_ingridient

      assert %Product{id: ^product_id} = Cookbook.find_product(%{name: name})
    end

    test "returns error changeset with invalid attributes" do
      %{recipe_id: recipe_id} = ingridient = insert(:ingridient)

      params = %{
        name: "",
        quantity: "",
        recipe_id: recipe_id
      }

      assert {:error, %Ecto.Changeset{}} = Cookbook.update_ingridient(ingridient, params)
    end
  end

  describe "delete_ingridient/1" do
    test "deletes the ingridient" do
      %{recipe: recipe} = ingridient = insert(:ingridient)
      assert {:ok, %Ingridient{}} = Cookbook.delete_ingridient(ingridient)

      assert Cookbook.list_ingridients(recipe) == []
    end
  end
end
