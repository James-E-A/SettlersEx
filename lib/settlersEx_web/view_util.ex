defmodule SettlersExWeb.Util do
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
  def coords_array(terrain, style) do
    visible_tiles = Map.keys(terrain); # board state API guarantees no terrain tile is nil, so no need to filter
    visible_edges =
      visible_tiles
      |> Stream.flat_map(&SettlersModel.adjacent_edges/1)
      |> MapSet.new()
    ;
    visible_intersections =
      visible_tiles
      |> Stream.flat_map(&SettlersModel.adjacent_intersections/1)
      |> MapSet.new()
    ;

    i_offset = Enum.min(Stream.map(visible_tiles, fn {0, {i, j}} -> (i - 0.5*j) end));
    j_offset = Enum.max(Stream.map(visible_tiles, fn {0, {_i, j}} -> j end))

    %{
      _style: style,
      _offsets: %{i: i_offset, j: j_offset},
      values: Map.new(
        Stream.concat([visible_tiles, visible_edges, visible_intersections]),
        fn loc -> {loc, coords(loc, style, %{i_offset: i_offset, j_offset: j_offset})} end
      )
    }
  end

  def coords(loc, :"point-top", %{i_offset: i_offset, j_offset: j_offset} \\ %{i_offset: 0, j_offset: 0}) do
    case loc do
      {0, {i, j}} ->
        i_ = i - i_offset;
        j_ = j_offset - j;
        %{
          x0: ((i_ - 0.5*j) + 0.5) * @inradius,
          y0: (j_ + 0.5) * @inradius * @half_sqrt_3,
        }
      {1, {i, j, k}} ->
        i_ = i - i_offset;
        j_ = j_offset - j;
        %{
          x0: ((i_ - 0.5*j) + case k do 0 -> 1; 1 -> 0.75; 2 -> 0.25 end) * @inradius, # FIXME estimate
          y0: (j_ + case k do 0 -> 0.5; 1 -> 0; 2 -> 0 end) * @inradius * @half_sqrt_3, # FIXME estimate
          rot: 90 - 60*k
        }
      {2, {i, j, k}} ->
        i_ = i - i_offset;
        j_ = j_offset - j;
        %{
          x0: ((i_ - 0.5*j) + case k do 0 -> 1; 1 -> 0.5 end) * @inradius,
          y0: (j_ + case k do 0 -> 0.171875; 1 -> -0.171875 end) * @inradius * @half_sqrt_3, # FIXME estimate
        }
    end
  end

  def viewBox(coords_array) do
    {x_ww, y_nn, x_ee, y_ss} = case coords_array._style do
      :"point-top" -> Enum.reduce(
        Map.values(coords_array.values),
        {0, 0, 0, 0},
        fn
          cur, {0, 0, 0, 0} ->
            {
              cur.x0,
              cur.y0,
              cur.x0,
              cur.y0
            }
          cur, {x_ww, y_nn, x_ee, y_ss} ->
            {
              min(x_ww, cur.x0),
              min(y_nn, cur.y0),
              max(x_ee, cur.x0),
              max(y_ss, cur.y0)
            }
        end
      )
    end

    %{ # cast result to weird format required by SVG spec
      "min-x": x_ww,
      "min-y": y_nn,
      width: ceil(x_ee - x_ww),
      height: ceil(y_ss - y_nn),
    }
  end

end
