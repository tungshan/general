require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.google.com/search?q=free+credit+report'))

doc.css('h3.r a.l').each do |link|
	puts link.content
end

doc.xpath('//h3/a[@class="1"]').each do |link|
	puts link.content
end

doc.search('h3.r a.l', '//h3/a[@class="1"]').each do |link|
	puts link.content
end
