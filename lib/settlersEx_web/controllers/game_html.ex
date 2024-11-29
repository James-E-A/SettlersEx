defmodule SettlersExWeb.GameHTML do
  use SettlersExWeb, :html
  import SettlersExWeb.Util
  import SettlersModel

  embed_templates "game/*"
end
