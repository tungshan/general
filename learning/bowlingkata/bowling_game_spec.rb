require File.expand_path('bowling_game')

describe "Game" do
	let(:game)	 { Game.new }

	def rollMany(rolls, pins)
		(1..rolls).each do 
			game.roll(pins)
		end
	end
	
	def rollSpare
		game.roll(5)
		game.roll(5)
	end

	def rollStrike
		game.roll(10)
	end

	describe "scores for complete games" do
		it "should be 0 for all gutter ball game" do
			rollMany(20, 0)
			game.score.should == 0
		end
	
		it "should be 20 for all ones game" do
			rollMany(20, 1)
			game.score.should == 20
		end

		it "should score game with single spare correctly" do
			rollSpare
			game.roll(3)
			rollMany(17,0)
			game.score.should == 16
		end

		it "should score game with single strike correctly" do
			rollStrike
			game.roll(3)
			game.roll(4)
			game.score.should == 24
		end

		it "should perfect game as 300" do
			12.times { rollStrike }
			game.score.should == 300
		end
	end
end
