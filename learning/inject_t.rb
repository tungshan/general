#Result gets 1st parameter passed in => 0
#element = 1 on 1st loop, 2 on 2nd loop, etc
#loops 4 times
sum = [1,2,3,4].inject(0) do |result, element|
	result + element
end
puts sum
#since no param passed in, result gets 1st element in enumerable => 1
#element = 2
#loops 3 times 
sum = [1,2,3,4].inject() do |result, element|
	result 
end
puts sum
#Converts an Array into a Hash
hash = [[:first_name, 'Roger'], [:last_name, 'Chang']].inject({}) do |result, element|
	result[element.first.to_s] = element.last.downcase
	result
end
puts hash

#Converts an Array into a Hash
Hash[*[[:first_name, 'Roger'], [:last_name, 'Chang']].flatten]
puts hash


#(...) means capture evenything enclosed... so $1 is user_agent of http_user_agent
#=~ equilvanet to /regex/.match
env = {'http_user_agent' => 'bot', 'http_cache_control' => 'max-age=0', 'path_info' => '/headers'}
def get_headers(env)
	env.inject({}) do |acc, (k,v)|
		acc[$1.downcase] = v if k =~ /^http_(.*)/i
		acc
	end
end
puts get_headers(env)
