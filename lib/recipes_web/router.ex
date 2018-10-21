defmodule RecipesWeb.Router do
  use RecipesWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", RecipesWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", RecipeController, :index)

    resources("/recipes", RecipeController) do
      resources("/ingridients", IngridientController, except: [:index, :show])
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RecipesWeb do
  #   pipe_through :api
  # end
end
