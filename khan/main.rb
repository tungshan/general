$LOAD_PATH << './../util/'
$LOAD_PATH << './'
require 'text'
require 'khan'
#grabs all the playlists from KhanAcademy.org & gets all the videos for each playlist
#outputs the playlist & videos in separate files for import into database
playlists = Khan::PlaylistManager.get_playlist

File.open("/tmp/playlist.txt", "w") do |file|
	playlists.each {|playlist| file.puts(Util::Text.to_line(playlist))}
end
File.open("/tmp/video.txt", "w") do |file|
	video_id = 1
	playlists.each do |playlist|
		videos = playlist.get_videos
		videos.each do |video|
			video.id = video_id
			video_id += 1
			file.puts(Util::Text.to_line(video))
		end
	end
end
