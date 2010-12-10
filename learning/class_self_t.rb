puts self

class Something
	puts self
	def initialize
		puts self
	end
	puts self
end
s = Something.new
#output =
#main
#Something
#Something
#<Something:ObjectId>
#Q: Why does 2nd Something output before #<Something:Objectid> ?
#A: The class definition runs it's executatble code first then it instantiates the class and calls the constructor
