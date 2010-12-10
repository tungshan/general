module Util
	module Text
		def Text.to_line(klass, delimiter = '|')
			vars = klass.instance_variables	
			line = ''
			vars.each do |var|
				line += "#{klass.instance_variable_get var}#{delimiter}"
			end
			line.chomp(delimiter)
		end
	end
end
