require 'set'

class Cell
    attr_accessor :coordinates
    attr_accessor :previous_cell
    def initialize(coordinates, previous_cell)
        @coordinates = coordinates
        @previous_cell = previous_cell
    end
end

class ChessBoard
    def initialize
        @size = 8
        @board = Array.new(@size) { Array.new(@size, 0) }
    end
    

    def valid_position?(x, y)
        x >= 0 && x < @size && y >= 0 && y < @size
    end

end

class Knight
    def initialize(x, y)
        @x = x
        @y = y
    end
      
    def position
        [@x, @y]
    end
      
    def set_position(x, y)
        @x = x
        @y = y
    end
end

class Game
    def initialize(start_position, end_position)
        @start_position = start_position
        @end_position = end_position
        @list = []
    end

    def knight_moves
        board = ChessBoard.new
        knight = Knight.new(@start_position[0], @start_position[1])
        queue = [[knight.position, 0]]
        visited = Set.new([knight.position])
        @list = [Cell.new(@start_position, nil)]
        moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]

        until queue.empty?
            
            current_position, depth = queue.shift
            
            return depth if current_position == @end_position
                
            moves.each do |move|
                new_x = current_position[0] + move[0]
                new_y = current_position[1] + move[1]
                if board.valid_position?(new_x, new_y) && !visited.include?([new_x, new_y])
                    knight.set_position(new_x, new_y)
                    visited << knight.position
                    queue <<[knight.position, depth + 1]
                    @list << Cell.new([new_x, new_y], current_position)
                end
            end
        end

        nil
    end
    
    def path
        
        list = [@end_position]
        for element in list
            for cell in @list
                if element == cell.coordinates
                    break if cell.previous_cell.nil?
                    list << cell.previous_cell
                end    
            end
        end
        p list.reverse
    end

end


game = Game.new([3, 3], [4, 3])

p game.knight_moves
game.path
