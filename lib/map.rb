require_relative "./cell_builder"
require_relative "./support/out_of_index_access"

class Map
  using OutOfIndexAccess

  attr_reader :rows

  def initialize(rows, cell_builder = CellBuilder)
    @rows, @cell_builder = rows, cell_builder
  end

  def self.parse(to_parse)
    parsed = to_parse.split(/\n/)
                     .map(&:chars)
    new(parsed)
  end

  def tick
    @rows = rows.each_with_index.map do |row, i|
      row.each_with_index.map do |_, j|
        @cell_builder.build_for(self, i, j).next_state
      end
    end
  end

  def at(i, j)
    return 0 if negative? i, j 
    rows[i][j].to_i
  end

  def to_s
    rows.map(&:join).join("\n")
  end

  private 

  def negative?(i, j)
    [i, j].any? { |num| num < 0 }
  end

end
# class NilClass
#   def [](i)
#     []
#   end
# end

