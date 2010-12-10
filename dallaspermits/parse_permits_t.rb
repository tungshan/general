require 'nokogiri'
require 'open-uri'

class String
	alias_method :old_strip, :strip
	def strip
		self.gsub(/^[\302\240|\s]*|[\302\240|\s]*$/, '').gsub(/(\n)|\s+/,' ') 
	end
end

doc = Nokogiri::HTML(open('abbr_permitsjan2008.html'))
#remove <span> tags within <td>
doc.css('table tr td span').each do |element|
	element.remove
end
doc.css('table tr').each do |element|
	line = ''
	element.css('td').each do |cell|
		line += "#{cell.content.strip}|"
		if cell['colspan'].to_i == 2
			line += '|'
		end
	end
	puts line.chomp('|')
end

## result is same as above
## this uses a string gsub to strip carriage returns
#file = open('abbr_permitsdec2008.html', 'rb')
#html = file.read #read method returns string
#file.close
#text = html.gsub(/(\n)|\s+/,' ') #strip carriage returns and extra space
#
##doc = Nokogiri::HTML(text)
#doc = Nokogiri::HTML(open('abbr_permitsdec2008.html'))
##remove <span> tags within <td>
#doc.css('table tr td span').each do |element|
#	element.remove
#end
#doc.css('table tr').each do |element|
#	line = ''
#	element.css('td').each do |cell|
#		line += "#{cell.content}|"
#	end
#	puts line.chomp('|')
#end
