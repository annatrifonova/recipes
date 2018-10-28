defmodule Recipes.Factory do
  use ExMachina.Ecto, repo: Recipes.Repo

  alias Recipes.Cookbook.{Recipe, Ingridient, Product}

  def recipe_factory do
    %Recipe{
      description: sequence(:description, &"Description #{&1}"),
      instructions: sequence(:instructions, &"Instructions #{&1}"),
      name: sequence(:name, &"Name #{&1}"),
      time: Enum.random(5..120)
    }
  end

  def ingridient_factory do
    %Ingridient{
      recipe: build(:recipe),
      product: build(:product),
      quantity: sequence(:quantity, &"Quantity #{&1}")
    }
  end

  def product_factory do
    %Product{
      name: sequence(:name, &"Product #{&1}")
    }
  end
end
