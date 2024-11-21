defmodule SettlersView.Util do
  @inradius 96.0
  @half_sqrt_3 :math.sqrt(0.75)
  def calc_coords(:tile, style, i, j, cols_offset, rows_offset) do
    case style do
      :"point-top" -> %{
        x0: (cols_offset/2 + i - j/2 + 0.5) * @inradius,
        y0: (rows_offset       - j   + 0.5) * @inradius * @half_sqrt_3,
        i: i, j: j
      }
    end
  end
  def calc_coords(:edge, style, i, j, k, cols_offset, rows_offset) do
    case style do
      :"point-top" -> %{
        x0: (cols_offset/2 + i - j/2 + elem({1,   0.75, 0.25, 0,   0.25, 0.75}, k)) * @inradius, # FIXME estimate
        y0: (rows_offset       - j   + elem({0.5, 0,    0,    0.5, 1,    1},    k)) * @inradius * @half_sqrt_3, # FIXME estimate
        rot: 90.0 - 60*k
      }
    end
  end
  def calc_coords(:intersection, style, i, j, k, cols_offset, rows_offset) do
    {rows_offset, k_} = {rows_offset + div(k, 3), rem(k, 3)};
    case style do
      :"point-top" -> %{
        x0: (cols_offset/2 + i - j/2 + elem({1,        0.5,       0,        0, 0.5, 1}, k )) * @inradius,
        y0: (rows_offset       - j   + elem({0.171875, -0.171875, 0.171875           }, k_)) * @inradius * @half_sqrt_3 # FIXME estimate
      }
    end
  end
  @substance_colors %{
    ocean: "DodgerBlue",
    hills: "DarkSalmon",
    forest: "ForestGreen",
    mountains: "DimGray",
    fields: "#efef30", # 20% of the way from Yellow to Silver
    pasture: "LightGreen",
    desert: "Khaki",
    gold_field: "Gold",
    brick: "DarkSalmon",
    lumber: "ForestGreen",
    ore: "DimGray",
    grain: "#efef30",
    wool: "LightGreen",
    _any: "White",
    _cardboard: "BlanchedAlmond"
  }
  def lookup_substance_color(substance) do
    @substance_colors[substance]
  end
  def flat_reduce(l, acc, fun) do
    Enum.reduce(l, acc, fn l1, acc1 -> Enum.reduce(l1, acc1, fun) end)
  end
  def zipx(enumerables) do
    Enum.zip_with(enumerables, fn enumerables_ -> Enum.zip(enumerables_) end)
  end
end
