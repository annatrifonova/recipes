defmodule Recipes.Factory do
  use ExMachina.Ecto, repo: Recipes.Repo

  alias Recipes.Cookbook.Recipe

  def recipe_factory do
    %Recipe{
      description: sequence(:description, &"Description #{&1}"),
      instructions: sequence(:instructions, &"Instructions #{&1}"),
      name: sequence(:name, &"Name #{&1}"),
      time: Enum.random(5..120)
    }
  end
end
