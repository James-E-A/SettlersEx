defmodule SettlersView.Util do
  @inradius 96.0
  @half_sqrt_3 :math.sqrt(0.75)
  def calc_coords(:"point-top", :tile, i, j, j_) do
    %{
      x0: (i - j/2 + 0.5) * @inradius,
      y0: (j_      + 0.5) * @inradius * @half_sqrt_3,
    }
  end
  def calc_coords(:"point-top", :edge, i, j, j_, k) do
    %{
      x0: (i - j/2 + elem({1,   0.75, 0.25, 0,   0.25, 0.75}, k)) * @inradius, # FIXME estimate
      y0: (j_      + elem({0.5, 0,    0,    0.5, 1,    1},    k)) * @inradius * @half_sqrt_3, # FIXME estimate
      rot: 90.0 - 60*k
    }
  end
  def calc_coords(:"point-top", :intersection, i, j, j_, k) do
    {j_, k_} = {j_ + div(k, 3), rem(k, 3)};
    %{
      x0: (i - j/2 + elem({1,        0.5,       0,        0, 0.5, 1}, k )) * @inradius,
      y0: (j_      + elem({0.171875, -0.171875, 0.171875           }, k_)) * @inradius * @half_sqrt_3 # FIXME estimate
    }
  end
  @terrain_colors %{
    ocean: "DodgerBlue",
    hills: "DarkSalmon",
    forest: "ForestGreen",
    mountains: "DimGray",
    fields: "#efef30", # 20% of the way from Yellow to Silver
    pasture: "LightGreen",
    desert: "Khaki",
    gold_field: "Gold",
    _cardboard: "BlanchedAlmond"
  }
  def lookup_tile_color(type) do
    @terrain_colors[type]
  end
end
