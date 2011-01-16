require File.expand_path('bowling_game')

describe "Frame" do
	let(:frame) { Frame.new }
	describe "scoring" do
		it "should report 0 when no scores added" do
			frame.total_score.should == 0
		end
		it "should be able to add one score" do
			frame.add_score(2)
			frame.total_score.should == 2	
		end
		it "should be able to add two scores" do
			frame.add_score(2)
			frame.add_score(3)
			frame.total_score.should == 5
		end
		it "should raise RangeError if adding score < 0" do
			expect {
				frame.add_score(-1)
			}.to raise_error(RangeError)
		end
	end
	it "is full when two scores are added" do
		frame.add_score(2)
		frame.add_score(1)
		frame.full?.should == true
	end
	it "is full when a strike is rolled" do
		frame.add_score(10)
		frame.full?.should == true
	end
end

describe "TenthFrame" do
	let(:tenth) { TenthFrame.new }
	context "#fullness" do
		it "is not full if first roll is a strike" do
			tenth.add_score(10)
			tenth.full?.should_not == true
		end
		it "is full when first two rolls are not a spare or strike" do
			tenth.add_score(2)
			tenth.add_score(3)
			tenth.full?.should == true
		end
		it "is not full when first two rolls are a spare" do
			tenth.add_score(5)
			tenth.add_score(5)
			tenth.full?.should_not == true
		end
		it "is not full when first two rolls are a strike" do
			tenth.add_score(10)
			tenth.add_score(10)
			tenth.full?.should_not == true
		end
		it "is full when there are three rolls" do
			tenth.add_score(10)
			tenth.add_score(10)
			tenth.add_score(10)
			tenth.full?.should == true
		end
	end
	context "#scoring" do
		it "should equal 30 for 3 strikes" do
			tenth.add_score(10)
			tenth.add_score(10)
			tenth.add_score(10)
			tenth.total_score.should == 30
		end
		it "should handle spare plus points" do
			tenth.add_score(5)
			tenth.add_score(5)
			tenth.add_score(10)
			tenth.total_score.should == 20
		end
	end
end
