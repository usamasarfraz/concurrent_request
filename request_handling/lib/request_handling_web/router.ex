defmodule RequestHandlingWeb.Router do
  use RequestHandlingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RequestHandlingWeb do
    pipe_through :api
    post "/", ApiController, :index
    post "/summary", ApiController, :summary
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:request_handling, :dev_routes) do

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
