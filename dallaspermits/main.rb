# encoding: utf-8
require 'permit'

#find all dallas permit urls from 2006 through 2010
#download each monthly permit page
#parse the file & save the file in a importable format in tmp
#SEE import_to_db.rb to import the files to db

#PRODUCTION
permit_pages = PermitPageManager.get_valid_permit_pages
permit_pages.each do |page|
	File.open("/tmp/#{page.date.to_s}.txt", "w") do |file|
		file.puts(page.get_parse_page)
	end
end
 
#TESTING 
#test_url = "http://www.dallascityhall.com/building_inspection/co_permits/PermitsAug2010.htm" 
#test_url = "permitsaug2010.htm"
#p = PermitPage.new(Date.parse('2010-01-01'), test_url)
#puts p.get_parse_page
