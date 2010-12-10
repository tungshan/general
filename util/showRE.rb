def showRE(a,re)
	if a =~ re
		"#{$`}<<#{$&}>>#{$'}"
	else
		"no match"
	end
end


#puts showRE('very interesting', /t/)
#puts showRE('Fats Waller', /ll/)
puts showRE('1/1/2001', /^\d{1,2}\/\d{1,2}[-\/][0-9]{4}$/) 
puts showRE('01/01/2001', /\d{1,2}[-\/]\d{1,2}[-\/][0-9]{4}( \d+:\d+:\d+)?/)
puts showRE('01/01/01', /\d{1,2}[-\/]\d{1,2}[-\/][0-9]{4}( \d+:\d+:\d+)?/)
puts showRE('2/9/2006 14:44:58', /\d{1,2}[-\/]\d{1,2}[-\/][0-9]{4}( \d+:\d+:\d+)?/) 
puts showRE('$500,000', /^\$\d(\d+|(,\d\d\d)+)?$/)
