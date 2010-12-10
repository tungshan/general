require 'nokogiri'
require 'open-uri'

class Playlist
	attr_accessor :name, :desc, :videolink	
	def initialize(name, desc = '')
		@name = name
		@desc = desc
	end
end

def get_playlist
	ROOT_URL = 'http://www.khanacademy.org'
	doc = Nokogiri::HTML(open(ROOT_URL))
	
	playlists = []
	doc.css('div#library-content-main h2.playlist-heading').each do |list_heading|
		list = Playlist.new("#{list_heading.content}")
		playlists << list 
	end
	list_counter = 0
	doc.css('div#library-content-main p.playlist-desc').each do |list_desc|
		list = playlists[list_counter]
		list.desc = list_desc.content
		list_counter += 1
	end
	list_counter = 0
	doc.css('div#library-content-main ol').each do |list_links|
		links = list_links.css('a.video-link')
		list = playlists[list_counter]
		list.videolink =  ROOT_URL + links.first['href']
		list_counter += 1
	end
	playlists
end
playlists.each do |list|
	puts "#{list.name}-#{list.desc}-#{list.videolink}\r\n"
end

#doc = Nokogiri::HTML(open('http://www.khanacademy.org/video/i-and-imaginary-numbers?playlist=Algebra'))
#nav = doc.css('nav.breadcrumbs_nav a')
#puts nav[1].content
#doc.css('form#video_selector option').each do |element|
#	puts "#{element.content} - #{element['value']}"
#end

