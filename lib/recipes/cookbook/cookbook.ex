defmodule Recipes.Cookbook do
  @moduledoc """
  The Cookbook context.
  """

  import Ecto.Query, warn: false

  alias Recipes.Repo
  alias Recipes.Cookbook.{Recipe, Ingridient, Product}

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes(%{name: name}) do
    Repo.all(
      from(
        Recipe,
        where: fragment("name ILIKE ?", ^"%#{name}%")
      )
    )
  end

  def list_recipes(_) do
    Repo.all(Recipe)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id), do: Repo.get!(Recipe, id)

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{source: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end

  def list_ingridients(%Recipe{id: recipe_id}) do
    Repo.all(
      from(
        Ingridient,
        where: [recipe_id: ^recipe_id],
        preload: [:product]
      )
    )
  end

  def get_ingridient!(id) do
    Repo.one!(
      from(
        Ingridient,
        where: [id: ^id],
        preload: [:product]
      )
    )
  end

  def create_ingridient(attr) do
    attr
    |> find_or_create_product()
    |> create_ingridient(attr)
  end

  defp create_ingridient(%Product{id: product_id}, attr) do
    %Ingridient{product_id: product_id}
    |> Ingridient.changeset(attr)
    |> Repo.insert()
  end

  defp create_ingridient({:ok, %Product{} = product}, attr) do
    create_ingridient(product, attr)
  end

  defp create_ingridient({:error, _reason} = error, _attr) do
    error
  end

  def update_ingridient(ingridient, attr) do
    attr
    |> find_or_create_product()
    |> update_ingridient(ingridient, attr)
  end

  defp update_ingridient(%Product{} = product, ingridient, attr) do
    ingridient
    |> Ingridient.put_product(product)
    |> Ingridient.changeset(attr)
    |> Repo.update()
  end

  defp update_ingridient({:ok, %Product{} = product}, ingridient, attr) do
    update_ingridient(product, ingridient, attr)
  end

  defp update_ingridient({:error, _reason} = error, _ingridient, _attr) do
    error
  end

  def delete_ingridient(ingridient) do
    Repo.delete(ingridient)
  end

  def change_ingridient(%Ingridient{product: %Product{name: name}} = ingridient) do
    Ingridient.changeset(ingridient, %{name: name})
  end

  def change_ingridient(%Ingridient{} = ingridient) do
    Ingridient.changeset(ingridient, %{})
  end

  defp find_or_create_product(attr) do
    find_product(attr) || create_product(attr)
  end

  def find_product(attr) do
    name = attr["name"] || attr[:name]
    Repo.get_by(Product, name: name)
  end

  defp create_product(attr) do
    %Product{}
    |> Product.changeset(attr)
    |> Repo.insert()
  end
end
