defmodule SettlersExWeb.GameController do
  use SettlersExWeb, :controller

  def game(conn, _params) do
    render(conn, :game, game: SettlersModel.new_game())
  end
end
