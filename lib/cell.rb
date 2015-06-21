class Cell
  attr_reader :current_state, :neighbours

  def initialize(state, neighbours)
    @current_state, @neighbours = state, neighbours
  end

  def count_of_live_neighbours
    neighbours.count { |state| state == 1 }
  end

  def next_state
    cell_type.next_state_for(count_of_live_neighbours)
  end

  private

  def cell_type
    current_state == 0 ? DeadCell : LiveCell
  end

  class DeadCell
    def self.next_state_for(count_of_live_neighbours)
      return 1 if count_of_live_neighbours == 3
      0
    end
  end

  class LiveCell
    def self.next_state_for(count_of_live_neighbours)
      return 1 if [2, 3].include? count_of_live_neighbours
      0
    end
  end
end
