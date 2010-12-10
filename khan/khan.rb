require 'nokogiri'
require 'open-uri'

module Khan
	class Video
		attr_accessor :id, :playlist_id, :title, :youtubevideoid, :sequence
		def initialize(id=0, playlist_id, title, youtubevideoid, sequence)
			@id = id
			@playlist_id = playlist_id
			@title = title
			@youtubevideoid = youtubevideoid
			@sequence = sequence
		end
	end
	class Playlist
		attr_accessor :id, :name, :desc, :videolink	
		def initialize(id, name, desc = '')
			@id = id
			@name = name
			@desc = desc
		end
		def get_videos
			videos = []
			sequence = 0
			doc = Nokogiri::HTML(open(@videolink))
			#nav = doc.css('nav.breadcrumbs_nav a')
			#puts nav[1].content
			doc.css('form#video_selector option').each do |element|
				video = Video.new(0, @id, element.content, element['value'], sequence)
				videos << video
				sequence += 1
			end
			videos
		end
	end
	
	class PlaylistManager
		@root_url = 'http://www.khanacademy.org'
		def self.get_playlist
			doc = Nokogiri::HTML(open(@root_url))
			
			playlists = []
			list_counter = 1
			doc.css('div#library-content-main h2.playlist-heading').each do |list_heading|
				newlist = Playlist.new(list_counter, "#{list_heading.content}")
				playlists << newlist 
				list_counter += 1
			end
			list_counter = 0
			doc.css('div#library-content-main p.playlist-desc').each do |list_desc|
				currentlist = playlists[list_counter]
				currentlist.desc = list_desc.content
				list_counter += 1
			end
			list_counter = 0
			doc.css('div#library-content-main ol').each do |list_links|
				links = list_links.css('a.video-link')
				currentlist = playlists[list_counter]
				currentlist.videolink =  @root_url + links.first['href']
				list_counter += 1
			end
			playlists
		end
	end
end
