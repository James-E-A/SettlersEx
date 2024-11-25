defmodule SettlersModel do
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
      terrain: Arrays.new([
        Arrays.new([%TerrainTile{type: :ocean}, %TerrainTile{type: :ocean}, %TerrainTile{type: :ocean}, %TerrainTile{type: :ocean}, nil, nil, nil]),
        Arrays.new([%TerrainTile{type: :ocean}, %TerrainTile{type: :hills, yield: 5}, %TerrainTile{type: :fields, yield: 6}, %TerrainTile{type: :pasture, yield: 11}, %TerrainTile{type: :ocean}, nil, nil]),
        Arrays.new([%TerrainTile{type: :ocean}, %TerrainTile{type: :forest, yield: 8}, %TerrainTile{type: :mountains, yield: 3}, %TerrainTile{type: :fields, yield: 4}, %TerrainTile{type: :pasture, yield: 5}, %TerrainTile{type: :ocean}, nil]),
        Arrays.new([%TerrainTile{type: :ocean}, %TerrainTile{type: :fields, yield: 9}, %TerrainTile{type: :forest, yield: 11}, %TerrainTile{type: :desert}, %TerrainTile{type: :forest, yield: 3}, %TerrainTile{type: :mountains, yield: 8}, %TerrainTile{type: :ocean}]),
        Arrays.new([nil, %TerrainTile{type: :ocean}, %TerrainTile{type: :fields, yield: 12}, %TerrainTile{type: :hills, yield: 6}, %TerrainTile{type: :pasture, yield: 4}, %TerrainTile{type: :hills, yield: 10}, %TerrainTile{type: :ocean}]),
        Arrays.new([nil, nil, %TerrainTile{type: :ocean}, %TerrainTile{type: :mountains, yield: 10}, %TerrainTile{type: :pasture, yield: 2}, %TerrainTile{type: :forest, yield: 9}, %TerrainTile{type: :ocean}]),
        Arrays.new([nil, nil, nil, %TerrainTile{type: :ocean}, %TerrainTile{type: :ocean}, %TerrainTile{type: :ocean}, %TerrainTile{type: :ocean}])
      ]),
      structures: %Catan.Structures{
        tiles: Arrays.new([
          Arrays.new([[%Structure{type: :port, detail: %{type: :_any, position: 1}}], [], [%Structure{type: :port, detail: %{type: :_any, position: 2}}], [], [], [], []]),
          Arrays.new([[], [], [], [], [%Structure{type: :port, detail: %{type: :wool, position: 2}}], [], []]),
          Arrays.new([[%Structure{type: :port, detail: %{type: :brick, position: 0}}], [], [], [], [], [], []]),
          Arrays.new([[], [], [], [%Structure{type: :robber}], [], [], [%Structure{type: :port, detail: %{type: :_any, position: 3}}]]),
          Arrays.new([[], [%Structure{type: :port, detail: %{type: :lumber, position: 0}}], [], [], [], [], []]),
          Arrays.new([[], [], [], [], [], [], [%Structure{type: :port, detail: %{type: :ore, position: 4}}]]),
          Arrays.new([[], [], [], [%Structure{type: :port, detail: %{type: :_any, position: 5}}], [], [%Structure{type: :port, detail: %{type: :grain, position: 4}}], []])
        ]),
        edges: Arrays.new([
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])]),
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])]),
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [%Structure{type: :road, owner: 0}], []]), Arrays.new([[], [%Structure{type: :road, owner: 3}], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])]),
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [%Structure{type: :road, owner: 1}], []]), Arrays.new([[], [], []]), Arrays.new([[%Structure{type: :road, owner: 0}], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])]),
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], [%Structure{type: :road, owner: 2}]]), Arrays.new([[], [], []]), Arrays.new([[%Structure{type: :road, owner: 2}], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])]),
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [%Structure{type: :road, owner: 1}], []]), Arrays.new([[], [%Structure{type: :road, owner: 3}], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])]),
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])]),
          Arrays.new([Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []]), Arrays.new([[], [], []])])
        ]),
        intersections: Arrays.new([
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []])]),
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []])]),
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], [%Structure{type: :settlement, owner: 0}]]), Arrays.new([[], [%Structure{type: :settlement, owner: 3}]]), Arrays.new([[], [%Structure{type: :settlement, owner: 0}]]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []])]),
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], [%Structure{type: :settlement, owner: 1}]]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], [%Structure{type: :settlement, owner: 2}]]), Arrays.new([[], []]), Arrays.new([[], []])]),
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], [%Structure{type: :settlement, owner: 2}]]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []])]),
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], [%Structure{type: :settlement, owner: 1}]]), Arrays.new([[%Structure{type: :settlement, owner: 3}], []]), Arrays.new([[], []]), Arrays.new([[], []])]),
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []])]),
          Arrays.new([Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []]), Arrays.new([[], []])])
        ])
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
