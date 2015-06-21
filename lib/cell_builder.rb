require_relative "./cell"

class CellBuilder
  def initialize(map, i, j)
    @map, @i, @j = map, i, j
  end

  def self.build_for(map, i, j)
    new(map, i, j).build
  end

  def build
    Cell.new(cell_state, neighbour_states)
  end

  def cell_state
    @map.at(@i, @j)
  end

  def neighbour_states
    neighbour_indices.map do |point|
      @map.at(*point)
    end
  end

  private

  def row_indices
    (@i-1..@i+1).to_a
  end

  def column_indices
    (@j-1..@j+1).to_a
  end

  def neighbour_indices
    row_indices.product(column_indices) - [[@i, @j]]
  end
end
