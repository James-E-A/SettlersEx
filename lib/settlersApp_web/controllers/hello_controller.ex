defmodule SettlersAppWeb.HelloController do
  use SettlersAppWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def game(conn, %{"id" => _id}) do
    g = SettlersModel.new_game(); # TODO
    render(conn, :game, game: g)
  end
end
