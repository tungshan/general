module Test
	def self.output(klass)
		puts klass.class
	end
	def Test.output2(klass)
		puts klass.class
	end
	def output3(klass)
		puts klass.class
	end
end

str = "roger"
Test.output(str)
Test.output2(str)
#Test.output3(str) doesn't work
