defmodule SettlersModel do

  def adjacent_edges(loc) do
    case loc do
      {0, {i, j}} ->
        [{1,{i,j,0}}, {1,{i,j,1}}, {1,{i,j,2}}, {1,{i-1,j,0}}, {1,{i-1,j-1,1}}, {1,{i,j-1,2}}]
      {1, {i, j, k}} ->
        case k do
          0 -> [{1,{i+1,j,2}}, {1,{i,j,1}}, {1,{i,j-1,2}}, {1,{i,j-1,1}}]
          1 -> [{1,{i+1,j,2}}, {1,{i,j+1,0}}, {i,j,2}, {i,j,0}]
          2 -> [{1,{i,j+1,0}}, {1,{i-1,j,1}}, {1,{i-1,j,0}}, {i,j,1}]
        end
      {2, {i, j, k}} ->
        case k do
          0 -> [{1,{i,j+1,2}}, {1,{i,j,1}}, {1,{i,j,0}}]
          1 -> [{1,{i,j+1,0}}, {1,{i,j,2}}, {1,{i,j,1}}]
        end
    end
  end

  def adjacent_intersections(loc) do
    case loc do
      {0, {i, j}} ->
        [{2,{i,j,0}}, {2,{i,j,1}}, {2,{i-1,j,0}}, {2,{i-1,j-1,1}}, {2,{i-1,j-1,0}}, {2,{i,j-1,1}}]
      {1, {i, j, k}} ->
        :TODO
      {2, {i, j, k}} ->
        case k do
          0 -> [{2,{i+1,j,1}}, {2,{i,j,1}}, {2,{i,j-1,1}}]
          1 -> [{2,{i,j+1,0}}, {2,{i-1,j,0}}, {2,{i,j,0}}]
        end
    end
  end

  defmodule Game do
    @enforce_keys [:state]
    defstruct [:state, :player_cosmetic]
  end

  defmodule GameState do
    @enforce_keys [:board, :players]
    defstruct [:board, :players, turn: 0]
  end

  defmodule Catan do
    @enforce_keys [:terrain, :structures, :_shape]
    defstruct [:terrain, :structures, :_shape]
  end

  defmodule Catan.Shape do
    @enforce_keys [:rows, :cols]
    defstruct [:rows, :cols]
  end

  defmodule TerrainTile do
    @enforce_keys [:type]
    defstruct [type: :ocean, yield: :nil]
  end

  defmodule Catan.Structures do
    @enforce_keys [:tiles, :edges, :intersections]
    defstruct [:tiles, :edges, :intersections]
  end

  defmodule Structure do
    @enforce_keys [:type]
    defstruct [type: :_undefined, owner: nil, detail: nil]
  end

  defmodule Player do
    defmodule Cosmetic do
      defstruct [:name, :color]
    end
    defstruct [:resource_hand, :development_hand]
  end

  def new_game(state \\ %GameState{
    board: %Catan{
      terrain: %{
        {0, {3, 6}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {4, 6}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {5, 6}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {6, 6}} => %SettlersModel.TerrainTile{type: :ocean},

        {0, {2, 5}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {3, 5}} => %SettlersModel.TerrainTile{type: :mountains, yield: 8},
        {0, {4, 5}} => %SettlersModel.TerrainTile{type: :hills, yield: 10},
        {0, {5, 5}} => %SettlersModel.TerrainTile{type: :forest, yield: 9},
        {0, {6, 5}} => %SettlersModel.TerrainTile{type: :ocean},

        {0, {1, 4}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {2, 4}} => %SettlersModel.TerrainTile{type: :pasture, yield: 5},
        {0, {3, 4}} => %SettlersModel.TerrainTile{type: :forest, yield: 3},
        {0, {4, 4}} => %SettlersModel.TerrainTile{type: :pasture, yield: 4},
        {0, {5, 4}} => %SettlersModel.TerrainTile{type: :pasture, yield: 2},
        {0, {6, 4}} => %SettlersModel.TerrainTile{type: :ocean},

        {0, {0, 3}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {1, 3}} => %SettlersModel.TerrainTile{type: :pasture, yield: 11},
        {0, {2, 3}} => %SettlersModel.TerrainTile{type: :fields, yield: 4},
        {0, {3, 3}} => %SettlersModel.TerrainTile{type: :desert},
        {0, {4, 3}} => %SettlersModel.TerrainTile{type: :hills, yield: 6},
        {0, {5, 3}} => %SettlersModel.TerrainTile{type: :mountains, yield: 10},
        {0, {6, 3}} => %SettlersModel.TerrainTile{type: :ocean},

        {0, {0, 2}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {1, 2}} => %SettlersModel.TerrainTile{type: :fields, yield: 6},
        {0, {2, 2}} => %SettlersModel.TerrainTile{type: :mountains, yield: 3},
        {0, {3, 2}} => %SettlersModel.TerrainTile{type: :forest, yield: 11},
        {0, {4, 2}} => %SettlersModel.TerrainTile{type: :fields, yield: 12},
        {0, {5, 2}} => %SettlersModel.TerrainTile{type: :ocean},

        {0, {0, 1}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {1, 1}} => %SettlersModel.TerrainTile{type: :hills, yield: 5},
        {0, {2, 1}} => %SettlersModel.TerrainTile{type: :forest, yield: 8},
        {0, {3, 1}} => %SettlersModel.TerrainTile{type: :fields, yield: 9},
        {0, {4, 1}} => %SettlersModel.TerrainTile{type: :ocean},

        {0, {0, 0}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {1, 0}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {2, 0}} => %SettlersModel.TerrainTile{type: :ocean},
        {0, {3, 0}} => %SettlersModel.TerrainTile{type: :ocean},
      },

      structures: %Catan.Structures{
        tiles: %{
          {0, {3, 6}} => [%Structure{type: :port, detail: %{type: :_any, position: 5}}],
          {0, {4, 6}} => [],
          {0, {5, 6}} => [%Structure{type: :port, detail: %{type: :wool, position: 4}}],
          {0, {6, 6}} => [],

          {0, {2, 5}} => [],
          {0, {3, 5}} => [],
          {0, {4, 5}} => [],
          {0, {5, 5}} => [],
          {0, {6, 5}} => [%Structure{type: :port, detail: %{type: :ore, position: 4}}],

          {0, {1, 4}} => [%Structure{type: :port, detail: %{type: :lumber, position: 0}}],
          {0, {2, 4}} => [],
          {0, {3, 4}} => [],
          {0, {4, 4}} => [],
          {0, {5, 4}} => [],
          {0, {6, 4}} => [],

          {0, {0, 3}} => [],
          {0, {1, 3}} => [],
          {0, {2, 3}} => [],
          {0, {3, 3}} => [%Structure{type: :robber}],
          {0, {4, 3}} => [],
          {0, {5, 3}} => [],
          {0, {6, 3}} => [%Structure{type: :port, detail: %{type: :_any, position: 3}}],

          {0, {0, 2}} => [%Structure{type: :port, detail: %{type: :brick, position: 0}}],
          {0, {1, 2}} => [],
          {0, {2, 2}} => [],
          {0, {3, 2}} => [],
          {0, {4, 2}} => [],
          {0, {5, 2}} => [],

          {0, {0, 1}} => [],
          {0, {1, 1}} => [],
          {0, {2, 1}} => [],
          {0, {3, 1}} => [],
          {0, {4, 1}} => [%Structure{type: :port, detail: %{type: :wool, position: 2}}],

          {0, {0, 0}} => [%Structure{type: :port, detail: %{type: :_any, position: 1}}],
          {0, {1, 0}} => [],
          {0, {2, 0}} => [%Structure{type: :port, detail: %{type: :_any, position: 2}}],
          {0, {3, 0}} => [],
        },

        edges: %{ # FIXME prune any physically unreachable entries out of this array
          {1, {2, 6, 0}} => [],
          {1, {2, 6, 1}} => [],
          {1, {2, 6, 2}} => [],
          {1, {3, 6, 0}} => [],
          {1, {3, 6, 1}} => [],
          {1, {3, 6, 2}} => [],
          {1, {4, 6, 0}} => [],
          {1, {4, 6, 1}} => [],
          {1, {4, 6, 2}} => [],
          {1, {5, 6, 0}} => [],
          {1, {5, 6, 1}} => [],
          {1, {5, 6, 2}} => [],
          {1, {6, 6, 0}} => [],
          {1, {6, 6, 1}} => [],
          {1, {6, 6, 2}} => [],

          {1, {1, 5, 0}} => [],
          {1, {1, 5, 1}} => [],
          {1, {1, 5, 2}} => [],
          {1, {2, 5, 0}} => [],
          {1, {2, 5, 1}} => [],
          {1, {2, 5, 2}} => [],
          {1, {3, 5, 0}} => [],
          {1, {3, 5, 1}} => [],
          {1, {3, 5, 2}} => [],
          {1, {4, 5, 0}} => [],
          {1, {4, 5, 1}} => [],
          {1, {4, 5, 2}} => [],
          {1, {5, 5, 0}} => [],
          {1, {5, 5, 1}} => [],
          {1, {5, 5, 2}} => [],
          {1, {6, 5, 0}} => [],
          {1, {6, 5, 1}} => [],
          {1, {6, 5, 2}} => [],

          {1, {0, 4, 0}} => [],
          {1, {0, 4, 1}} => [],
          {1, {0, 4, 2}} => [],
          {1, {1, 4, 0}} => [],
          {1, {1, 4, 1}} => [],
          {1, {1, 4, 2}} => [],
          {1, {2, 4, 0}} => [],
          {1, {2, 4, 1}} => [],
          {1, {2, 4, 2}} => [],
          {1, {3, 4, 0}} => [],
          {1, {3, 4, 1}} => [%Structure{type: :road, owner: 1}],
          {1, {3, 4, 2}} => [],
          {1, {4, 4, 0}} => [],
          {1, {4, 4, 1}} => [%Structure{type: :road, owner: 3}],
          {1, {4, 4, 2}} => [],
          {1, {5, 4, 0}} => [],
          {1, {5, 4, 1}} => [],
          {1, {5, 4, 2}} => [],
          {1, {6, 4, 0}} => [],
          {1, {6, 4, 1}} => [],
          {1, {6, 4, 2}} => [],

          {1, {-1, 3, 0}} => [],
          {1, {-1, 3, 1}} => [],
          {1, {-1, 3, 2}} => [],
          {1, {0, 3, 0}} => [],
          {1, {0, 3, 1}} => [],
          {1, {0, 3, 2}} => [],
          {1, {1, 3, 0}} => [],
          {1, {1, 3, 1}} => [],
          {1, {1, 3, 2}} => [],
          {1, {2, 3, 0}} => [],
          {1, {2, 3, 1}} => [],
          {1, {2, 3, 2}} => [%Structure{type: :road, owner: 2}],
          {1, {3, 3, 0}} => [],
          {1, {3, 3, 1}} => [],
          {1, {3, 3, 2}} => [],
          {1, {4, 3, 0}} => [%Structure{type: :road, owner: 2}],
          {1, {4, 3, 1}} => [],
          {1, {4, 3, 2}} => [],
          {1, {5, 3, 0}} => [],
          {1, {5, 3, 1}} => [],
          {1, {5, 3, 2}} => [],
          {1, {6, 3, 0}} => [],
          {1, {6, 3, 1}} => [],
          {1, {6, 3, 2}} => [],

          {1, {-1, 2, 0}} => [],
          {1, {-1, 2, 1}} => [],
          {1, {-1, 2, 2}} => [],
          {1, {0, 2, 0}} => [],
          {1, {0, 2, 1}} => [],
          {1, {0, 2, 2}} => [],
          {1, {1, 2, 0}} => [],
          {1, {1, 2, 1}} => [%Structure{type: :road, owner: 1}],
          {1, {1, 2, 2}} => [],
          {1, {2, 2, 0}} => [],
          {1, {2, 2, 1}} => [],
          {1, {2, 2, 2}} => [],
          {1, {3, 2, 0}} => [%Structure{type: :road, owner: 0}],
          {1, {3, 2, 1}} => [],
          {1, {3, 2, 2}} => [],
          {1, {4, 2, 0}} => [],
          {1, {4, 2, 1}} => [],
          {1, {4, 2, 2}} => [],
          {1, {5, 2, 0}} => [],
          {1, {5, 2, 1}} => [],
          {1, {5, 2, 2}} => [],
          {1, {6, 2, 0}} => [],
          {1, {6, 2, 1}} => [],
          {1, {6, 2, 2}} => [],

          {1, {-1, 1, 0}} => [],
          {1, {-1, 1, 1}} => [],
          {1, {-1, 1, 2}} => [],
          {1, {0, 1, 0}} => [],
          {1, {0, 1, 1}} => [],
          {1, {0, 1, 2}} => [],
          {1, {1, 1, 0}} => [],
          {1, {1, 1, 1}} => [%Structure{type: :road, owner: 0}],
          {1, {1, 1, 2}} => [],
          {1, {2, 1, 0}} => [],
          {1, {2, 1, 1}} => [%Structure{type: :road, owner: 3}],
          {1, {2, 1, 2}} => [],
          {1, {3, 1, 0}} => [],
          {1, {3, 1, 1}} => [],
          {1, {3, 1, 2}} => [],
          {1, {4, 1, 0}} => [],
          {1, {4, 1, 1}} => [],
          {1, {4, 1, 2}} => [],
          {1, {5, 1, 0}} => [],
          {1, {5, 1, 1}} => [],
          {1, {5, 1, 2}} => [],

          {1, {-1, 0, 0}} => [],
          {1, {-1, 0, 1}} => [],
          {1, {-1, 0, 2}} => [],
          {1, {0, 0, 0}} => [],
          {1, {0, 0, 1}} => [],
          {1, {0, 0, 2}} => [],
          {1, {1, 0, 0}} => [],
          {1, {1, 0, 1}} => [],
          {1, {1, 0, 2}} => [],
          {1, {2, 0, 0}} => [],
          {1, {2, 0, 1}} => [],
          {1, {2, 0, 2}} => [],
          {1, {3, 0, 0}} => [],
          {1, {3, 0, 1}} => [],
          {1, {3, 0, 2}} => [],
          {1, {4, 0, 0}} => [],
          {1, {4, 0, 1}} => [],
          {1, {4, 0, 2}} => [],

          {1, {-1, -1, 0}} => [],
          {1, {-1, -1, 1}} => [],
          {1, {-1, -1, 2}} => [],
          {1, {0, -1, 0}} => [],
          {1, {0, -1, 1}} => [],
          {1, {0, -1, 2}} => [],
          {1, {1, -1, 0}} => [],
          {1, {1, -1, 1}} => [],
          {1, {1, -1, 2}} => [],
          {1, {2, -1, 0}} => [],
          {1, {2, -1, 1}} => [],
          {1, {2, -1, 2}} => [],
          {1, {3, -1, 0}} => [],
          {1, {3, -1, 1}} => [],
          {1, {3, -1, 2}} => [],
        },

        intersections: %{ # FIXME prune any physically unreachable entries out of this array
          {2, {2, 6, 0}} => [],
          {2, {2, 6, 1}} => [],
          {2, {3, 6, 0}} => [],
          {2, {3, 6, 1}} => [],
          {2, {4, 6, 0}} => [],
          {2, {4, 6, 1}} => [],
          {2, {5, 6, 0}} => [],
          {2, {5, 6, 1}} => [],
          {2, {6, 6, 0}} => [],
          {2, {6, 6, 1}} => [],

          {2, {1, 5, 0}} => [],
          {2, {1, 5, 1}} => [],
          {2, {2, 5, 0}} => [],
          {2, {2, 5, 1}} => [],
          {2, {3, 5, 0}} => [],
          {2, {3, 5, 1}} => [],
          {2, {4, 5, 0}} => [],
          {2, {4, 5, 1}} => [],
          {2, {5, 5, 0}} => [],
          {2, {5, 5, 1}} => [],
          {2, {6, 5, 0}} => [],
          {2, {6, 5, 1}} => [],

          {2, {0, 4, 0}} => [],
          {2, {0, 4, 1}} => [],
          {2, {1, 4, 0}} => [],
          {2, {1, 4, 1}} => [],
          {2, {2, 4, 0}} => [],
          {2, {2, 4, 1}} => [],
          {2, {3, 4, 0}} => [],
          {2, {3, 4, 1}} => [%Structure{type: :settlement, owner: 1}],
          {2, {4, 4, 0}} => [%Structure{type: :settlement, owner: 3}],
          {2, {4, 4, 1}} => [],
          {2, {5, 4, 0}} => [],
          {2, {5, 4, 1}} => [],
          {2, {6, 4, 0}} => [],
          {2, {6, 4, 1}} => [],

          {2, {-1, 3, 0}} => [],
          {2, {-1, 3, 1}} => [],
          {2, {0, 3, 0}} => [],
          {2, {0, 3, 1}} => [],
          {2, {1, 3, 0}} => [],
          {2, {1, 3, 1}} => [],
          {2, {2, 3, 0}} => [],
          {2, {2, 3, 1}} => [%Structure{type: :settlement, owner: 2}],
          {2, {3, 3, 0}} => [],
          {2, {3, 3, 1}} => [],
          {2, {4, 3, 0}} => [],
          {2, {4, 3, 1}} => [],
          {2, {5, 3, 0}} => [],
          {2, {5, 3, 1}} => [],
          {2, {6, 3, 0}} => [],
          {2, {6, 3, 1}} => [],

          {2, {-1, 2, 0}} => [],
          {2, {-1, 2, 1}} => [],
          {2, {0, 2, 0}} => [],
          {2, {0, 2, 1}} => [],
          {2, {1, 2, 0}} => [],
          {2, {1, 2, 1}} => [%Structure{type: :settlement, owner: 1}],
          {2, {2, 2, 0}} => [],
          {2, {2, 2, 1}} => [],
          {2, {3, 2, 0}} => [],
          {2, {3, 2, 1}} => [],
          {2, {4, 2, 0}} => [],
          {2, {4, 2, 1}} => [%Structure{type: :settlement, owner: 2}],
          {2, {5, 2, 0}} => [],
          {2, {5, 2, 1}} => [],
          {2, {6, 2, 0}} => [],
          {2, {6, 2, 1}} => [],

          {2, {-1, 1, 0}} => [],
          {2, {-1, 1, 1}} => [],
          {2, {0, 1, 0}} => [],
          {2, {0, 1, 1}} => [],
          {2, {1, 1, 0}} => [],
          {2, {1, 1, 1}} => [%Structure{type: :settlement, owner: 0}],
          {2, {2, 1, 0}} => [],
          {2, {2, 1, 1}} => [%Structure{type: :settlement, owner: 3}],
          {2, {3, 1, 0}} => [],
          {2, {3, 1, 1}} => [%Structure{type: :settlement, owner: 0}],
          {2, {4, 1, 0}} => [],
          {2, {4, 1, 1}} => [],
          {2, {5, 1, 0}} => [],
          {2, {5, 1, 1}} => [],

          {2, {-1, 0, 0}} => [],
          {2, {-1, 0, 1}} => [],
          {2, {0, 0, 0}} => [],
          {2, {0, 0, 1}} => [],
          {2, {1, 0, 0}} => [],
          {2, {1, 0, 1}} => [],
          {2, {2, 0, 0}} => [],
          {2, {2, 0, 1}} => [],
          {2, {3, 0, 0}} => [],
          {2, {3, 0, 1}} => [],
          {2, {4, 0, 0}} => [],
          {2, {4, 0, 1}} => [],

          {2, {-1, -1, 0}} => [],
          {2, {-1, -1, 1}} => [],
          {2, {0, -1, 0}} => [],
          {2, {0, -1, 1}} => [],
          {2, {1, -1, 0}} => [],
          {2, {1, -1, 1}} => [],
          {2, {2, -1, 0}} => [],
          {2, {2, -1, 1}} => [],
          {2, {3, -1, 0}} => [],
          {2, {3, -1, 1}} => [],
        }
      },
      _shape: %Catan.Shape{rows: 7, cols: 7}
    },
    players: Arrays.new([
      %Player{
        development_hand: %{},
        resource_hand: %{ore: 1, lumber: 1, brick: 1}
      },
      %Player{
        development_hand: %{},
        resource_hand: %{lumber: 2, grain: 1}
      },
      %Player{
        development_hand: %{},
        resource_hand: %{brick: 1, grain: 1, lumber: 1}
      },
      %Player{
        development_hand: %{},
        resource_hand: %{grain: 2, ore: 1}
      }
    ])
  }, player_cosmetic \\ Arrays.new([
    %Player.Cosmetic{name: "Player 1", color: "blue"},
    %Player.Cosmetic{name: "Player 2", color: "red"},
    %Player.Cosmetic{name: "Player 3", color: "white"},
    %Player.Cosmetic{name: "Player 4", color: "orange"},
  ])) do
    %Game{state: state, player_cosmetic: player_cosmetic}
  end
end
