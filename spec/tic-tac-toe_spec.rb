require_relative "../tic-tac-toe.rb"

describe Board do
  let(:board) {Board.new}
  describe "#finished" do
    context "when top row all X" do
      it "shows someone won" do
        board.state = {tl: 'X', t: 'X', tr: 'X'}
        expect(board.finished).to eq 1
      end
    end
    context "when all cells are covered but noone wins" do
      it "shows noone won" do
        board.state = {tl:'X', t:'O', tr: 'X',
                       l:'X', c: 'O', r:'X',
                       bl:'O', v:'X', br:'O'}
        expect(board.finished).to eq 2
      end
    end
  end
end

describe User do
  describe ".num_players" do
    it "returns correct number of players" do
      User.new "giorgos"
      User.new "nice"
      User.new "job"
      expect(User.num_players).to eq 3
    end

  end
end
