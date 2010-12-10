class MyClass
	def initialize(name, desc)
		@name = name
		@desc = desc
	end
end

klass = MyClass.new('Roger', 'Cool')

vars = klass.instance_variables
vars.each do |var|
	puts "#{var[1,var.length-1]}=#{klass.instance_variable_get var}"
end
