defmodule SettlersExWeb.GameLive do
  use Phoenix.LiveView

  def mount(params, _session, socket) do
    game = SettlersModel.new_game();
    {:ok, assign(socket, game: game)}
  end

  def render(assigns) do
    SettlersExWeb.GameHTML.game(assigns)
  end

end
