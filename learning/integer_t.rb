#Fixnum class is a immutable object in ruby

value = 1

def inc_number_by2(number)
	add = number + 2
	multi = number * 2
	[add, multi]
end

value,new_value = inc_number_by2(value)
puts value
