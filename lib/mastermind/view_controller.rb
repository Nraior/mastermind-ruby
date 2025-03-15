class ViewController
  def display_board(board)
    board.board.each do |level|
      p level.join(' ')
    end
    puts ''
  end

  def display_board_level(board, level)
    p board[level].join(' ')
  end

  def display_code(secret_code)
    p secret_code
  end
end
