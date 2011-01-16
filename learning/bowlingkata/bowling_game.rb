
class Frame
	def initialize
		@scores = []
	end
	
	def add_score(pins)
		raise RangeError, "pins must be greater than 0" if pins < 0
		@scores << pins 
		if self.strike?
			@scores << 0
		end
	end

	def full?
		@scores.length == 2
	end

	def first_score
		@scores[0].nil? ? 0 : @scores[0]
	end

	def second_score
		@scores[1].nil? ? 0 : @scores[0]
	end

	def spare?
		total_score == 10 && !strike?	
	end

	def strike?
		@scores[0] == 10
	end

	def total_score
		@scores.length > 0 ? @scores.inject { |total, score| total + score } : 0 
	end
end

class TenthFrame < Frame
	def add_score(pins)
		raise RangeError, "pins must be greater than 0" if pins < 0
		@scores << pins
	end

	def full?
		return (self.first_score + self.second_score) < 10 if @scores.length == 2	
		return @scores.length == 3 ? true : false
	end

	def spare?
		false
	end

	def strike?
		false
	end
end

class ScoreKeeper
	def initialize
		@frames = Array.new(9) { Frame.new }
		@frames << TenthFrame.new
		@current_frame_num = 0
	end

	def record_score(pins)
		current_frame = @frames[@current_frame_num]
		current_frame.add_score(pins)
		if current_frame.full?
			@current_frame_num += 1
		end
	end
	
	def score
		total_score = 0
		(0...10).each do |frame_num|
			frame = @frames[frame_num]
			if frame.strike?
				total_score += strike_bonus(frame_num)
			elsif frame.spare?
				total_score += spare_bonus(frame_num)
			end
			total_score += frame.total_score	
		end
		total_score
	end

protected
	def spare_bonus(frame_num)
		@frames[frame_num+1].first_score
	end
	def strike_bonus(frame_num)
		next_frame = @frames[frame_num+1]
		return next_frame.first_score + @frames[frame_num+2].first_score if next_frame.strike?
		return next_to_last_frame?(frame_num) ? next_frame.first_score + next_frame.second_score : next_frame.total_score
	end
	def next_to_last_frame?(frame_num)
		return frame_num == 8	
	end

end

class Game
	def initialize
		@scorekeeper = ScoreKeeper.new
	end

	def roll(pins)
		@scorekeeper.record_score(pins)
	end

	def score
		@scorekeeper.score
	end
end
