class Square
  attr_accessor :arr, :position, :visited, :level

  def initialize(position)
    @arr = []
    @position = position
    @visited = false
    @level = nil
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = Array.new (8) { Array.new(8) }
  end

  def populate_board
    8.times do |i|
      8.times do |j|
        @board[i][j] = Square.new([i, j])
      end
    end
  end

  def list_moves
    8.times do |i|
      8.times do |j|
        @board[i][j].arr.push [i + 2, j + 1] if i < 6 && j < 7
        @board[i][j].arr.push [i + 2, j - 1] if i < 6 && j > 0
        @board[i][j].arr.push [i - 2, j + 1] if i > 1 && j < 7
        @board[i][j].arr.push [i - 2, j - 1] if i > 1 && j > 0
        @board[i][j].arr.push [i + 1, j + 2] if i < 7 && j < 6
        @board[i][j].arr.push [i + 1, j - 2] if i < 7 && j > 1
        @board[i][j].arr.push [i - 1, j + 2] if i > 0 && j < 6
        @board[i][j].arr.push [i - 1, j - 2] if i > 0 && j > 1
      end
    end
  end

  def knights_moves(source, target)
    tmp = @board[source[0]][source[1]]
    tmp.level = 0
    queue = [tmp]
    i = 0

    until queue.empty? || tmp.position == target
      if tmp.visited
        queue.shift
        tmp = queue[0]
        next
      end

      tmp.visited = true

      tmp.arr.each do |v|
        queue.push @board[v[0]][v[1]] unless @board[v[0]][v[1]].visited
        queue.last.level = tmp.level + 1
      end

      queue.shift
      tmp = queue[0]
      i += 1
    end

    if tmp.position == target
      puts "We found it! and it's #{tmp.level} moves"
    end
  end
end

game = Board.new

game.populate_board
game.list_moves

puts game.knights_moves([7, 0], [0, 7])