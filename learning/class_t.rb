class Point
	@a = 0
	@b = 0
	attr_accessor :x, :y
	def initialize(x,y)
		@x, @y = x, y
	end
	def to_s
		"(#@x,#@y)"
	end
	class << self # Class methods go here
		attr_accessor :a, :b
		def msg
			'Static method'
		end
	end
end
class Point2 < Point
	@a = 1
	@b = 1
end
p = Point.new(1,2)
puts p
p.x = 2
puts p
puts Point.msg
puts Point.a.class
puts Point.a
#puts p.a.class
puts Point2.a
