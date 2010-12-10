# encoding: utf-8
require 'net/http'
require 'date'
require 'nkf'
require 'nokogiri'
require 'open-uri'
require File.expand_path('extension')
require File.join(File.dirname(__FILE__), 'regex')

class PermitPageManager
	@base_url = 'http://www.dallascityhall.com/building_inspection/co_permits/Permits'
	@url_ext = %w[html htm]
	@month = ['jan','feb','mar','apr','may','jun','june','jul','july','aug','sep','sept','oct','nov','dec']
	#@month = ['aug']
	@year = %w[2006 2007 2008 2009 2010]
	def self.get_valid_permit_pages
		permitpages = []
		@month.each do |month|
			@year.each do |year|
				@url_ext.each do |ext|
					if Web.valid_url?(("#{@base_url}#{month}#{year}.#{ext}"))
						permitpages << PermitPage.new(Date.parse("#{year}-#{month}-1"), "#{@base_url}#{month}#{year}.#{ext}")
					end
				end
			end
		end
		permitpages
	end

	class << self
	end
end

class PermitPage
	attr :date, :url
	def initialize(date, url)
		@date = date
		@url = url
	end
	def get_parse_page
		parse_page = ''
		doc = Nokogiri::HTML(get_page)
		doc.encoding = NKF.guess(doc).to_s
		#remove <span> tags within <td>
		doc.css('table tr td span').each do |element|
			element.remove
		end
		doc.css('table tr').each do |element|
			line = ''
			element.css('td').each do |cell|
				result = cell.content.custom_strip
				if result.match(Regex::DATE_LOOSE) #contains 4 digit yr
					result = result[0, result.rindex('/')+1] + result[result.rindex('/')+3,2]
				end
				if result.match(Regex::DOLLAR_CURRENCY)
					result = result[1,result.length-1].gsub(',','')
				end
				line += "#{result}|"
				if cell['colspan'].to_i == 2
					line += '|'
				end
			end
			if !line.match(/\|\|\|\|/)  #don't add lines that have 4 consecutive pipes
				parse_page << line.chomp('|') << "\r\n"
			end
		end
		parse_page
	end
	def get_page
		open(@url, "r:windows-1252").read()
	end
end

class Web
	def self.valid_url? url
		true if Net::HTTP.get_response(URI.parse(url)).is_a? Net::HTTPOK
	end
	def self.test_check_url_response urls
		urls.each do |date,url|
			puts "#{date} - #{url}"
		end
	end
end
#PRODUCTION
#permit_pages = PermitPageManager.get_valid_permit_pages
#permit_pages.each do |page|
#	File.open("/tmp/#{page.date.to_s}.txt", "w") do |file|
#		file.puts(page.get_parse_page)
#	end
#end
 
#TESTING 
#test_url = "http://www.dallascityhall.com/building_inspection/co_permits/PermitsAug2010.htm" 
#test_url = "permitsaug2010.htm"
#p = PermitPage.new(Date.parse('2010-01-01'), test_url)
#puts p.get_parse_page
