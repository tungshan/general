class Array
	def find2
		for i in 0...size
			value = self[i]
			return value if yield(value)
		end
		return nil
	end
end
p [1,3,5,5,9].find2{|v| v*v > 30 }
