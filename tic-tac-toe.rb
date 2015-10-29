class User

  @@num_players = 0

  def User.num_players
    return @@num_players
  end

  attr_reader :name
  attr_reader :symbol

  def initialize(name)
    @name = name
    @@num_players += 1

    if @@num_players == 1
      @symbol = 'x'
    else
      @symbol = 'o'
    end
  end

end

class Board

  attr_accessor :state

  def initialize
    @state = {tl: ' ', t: ' ', tr: ' ',
              l: ' ', c: ' ', r: ' ',
              bl: ' ', b: ' ', br: ' '}
  end

  def draw
    puts " #{@state[:tl]} | #{@state[:t]} | #{@state[:tr]}"
    puts "-----------"
    puts " #{@state[:l]} | #{@state[:c]} | #{@state[:r]}"
    puts "-----------"
    puts " #{@state[:bl]} | #{@state[:b]} | #{@state[:br]}"
  end

  def finished
     # 0 if not finished
     # 1 if someone won
     # 2 if draw

    case
    when @state[:tl] == @state[:t] &&
      @state[:tl] == @state[:tr] &&
      @state[:tl] != ' '
      return 1
    when @state[:l] == @state[:c] &&
      @state[:l] == @state[:r] &&
      @state[:l] != ' '
      return 1
    when @state[:bl] == @state[:b] &&
      @state[:bl] == @state[:br] &&
      @state[:bl] != ' '
      return 1
    when @state[:tl] == @state[:c] &&
      @state[:tl] == @state[:br] &&
      @state[:tl] != ' '
      return 1
    when @state[:tr] == @state[:c] &&
      @state[:tr] == @state[:bl] &&
      @state[:tr] != ' '
      return 1
    when @state[:tl] == @state[:l] &&
      @state[:tl] == @state[:bl] &&
      @state[:tl] != ' '
      return 1
    when @state[:t] == @state[:c] &&
      @state[:t] == @state[:b] &&
      @state[:t] != ' '
      return 1
    when @state[:tr] == @state[:r] &&
      @state[:tr] == @state[:br] &&
      @state[:tr] != ' '
      return 1
    when @state.all? {|key, value| value != ' '}
      return 2
    else
      return 0
    end

  end

end

class Game

  def begin

    @user = []
    puts("Hello player 1.\nWhat's your name?")
    @user[0] = User.new(gets.chomp)
    puts("Hello player 2.\nWhat's your name?")
    @user[1] = User.new(gets.chomp)
    puts("OK! It's #{@user[0].name} VS #{@user[1].name}")

    board = Board.new
    board.draw

    # turn: 0 -> player 1
    # turn: 1 -> player 2
    turn = 0

    while board.finished == 0
      puts("#{@user[turn].name} it's your turn. Where do you want to play?")
      move = gets.chomp
      if ((%w[tl t tr l c r bl b br].include? move) &&
          (board.state[move.to_sym] == " "))

        board.state[move.to_sym] = @user[turn].symbol
        board.draw
        turn = (turn+1) % 2
      else
        puts("Invalid move. Think again")
      end
    end

    if board.finished == 1
      puts("Congratulations #{@user[(turn + 1) %2].name}! You won!")
    else
      puts "That's a draw. Too bad for both of you!"
    end
  end

end

# game = Game.new
# game.begin
