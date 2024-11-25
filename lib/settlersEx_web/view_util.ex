defmodule SettlersView.Util do
  @material_colors %{

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
  def material_color(name) do
    @material_colors[name]
  end

  @inradius 96.0
  @half_sqrt_3 :math.sqrt(0.75)
  def coords_array(:"point-top", shape) do
    # include negative "index" for roads and tiles on the south-west edge
    cols_range = -1..(shape.cols - 1);
    rows_range = -1..(shape.rows - 1);
    j_offset = 6; # FIXME
    i_offset = -1.5; # FIXME
    weave(
      [rows_range, cols_range],
      fn {j, i} ->
        i_ = i - i_offset;
        j_ = j_offset - j;
        %{
          x0: ((i_ - 0.5*j) + 0.5) * @inradius,
          x_ww: (i_ - 0.5*j) * @inradius,
          x_ee: ((i_ - 0.5*j) + 1) * @inradius,
          x_e1: ((i_ - 0.5*j) + 0.75) * @inradius, # FIXME ESTIMATE

          y0: (j_ + 0.5) * @inradius * @half_sqrt_3,
          y_n1: (j_ + 0.171875) * @inradius * @half_sqrt_3, # FIXME estimate
          y_n2: (j_ - 0.078125) * @inradius * @half_sqrt_3, # FIXME estimate
          y_n3: (j_ - 0.125) * @inradius * @half_sqrt_3, # FIXME estimate
          y_nn: (j_ - 0.171875) * @inradius * @half_sqrt_3, # FIXME estimate

          y_ss: (j_ + 1.078125) * @inradius * @half_sqrt_3, # FIXME estimate
          y_s3: (j_ + 1.078125) * @inradius * @half_sqrt_3, # FIXME estimate
        }
      end
    )
  end

  defp weave([enumerable_1, enumerable_2], fun) do
    enumerable_1
    |> Stream.map(fn a -> {
      a,
      enumerable_2
      |> Stream.map(fn b -> {
        b,
        fun.({a, b})
      } end)
      |> Map.new()
    } end)
    |> Map.new()
  end

  def viewBox(coords_array, terrain) do
    stream_2d_map(coords_array)
    |> Stream.filter(fn {j, i, _cur} -> (
      j >= 0
      and i >= 0
      and not is_nil(terrain[j][i])
    ) end)
    |> Enum.reduce(nil, fn
      {_j, _i, cur}, nil ->
        %{
          x_ww: cur.x_ww,
          y_nn: cur.y_n3,
          x_ee: cur.x_ee,
          y_ss: cur.y_s3
        }
      {_j, _i, cur}, acc ->
        %{
          x_ww: min(acc.x_ww, cur.x_ww),
          y_nn: min(acc.y_nn, cur.y_n3),
          x_ee: max(acc.x_ee, cur.x_ee),
          y_ss: max(acc.y_ss, cur.y_s3)
        }
    end)
    |> (fn coords -> %{
      "min-x": coords.x_ww,
      "min-y": coords.y_nn,
      width: coords.x_ee - coords.x_ww,
      height: coords.y_ss - coords.y_nn,
    } end).()
  end

  def stream_2d_map(m1) do
    Stream.concat(
      Stream.map(m1, fn {k1, m2} ->
        Stream.map(m2, fn {k2, v} ->
          {k1, k2, v}
        end)
      end)
    )
  end

end
