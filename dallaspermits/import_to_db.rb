require 'active_record'
require 'active_support'

def activerecord_connect
	ActiveRecord::Base.establish_connection(:adapter => 'mysql2', :host => 'localhost', :username => 'root', :password => 'fzupsjsa1', :database => 'permit')
end

def loadfile(table_name, file_name)
	ActiveRecord::Base.connection.execute("LOAD DATA INFILE '#{File.join('/tmp', file_name)}' INTO TABLE #{table_name} FIELDS TERMINATED BY '|' IGNORE 1 LINES (PermitType, PermitNo, @date, Address, Mapsco, Contractor, @value, Area, WorkDescription, LandUse) SET Issued = str_to_date(@date, '%m/%d/%y'),Value = coalesce(nullif(@value, ''),0) ;")
end

def loadfile_4digityear(table_name, file_name)
	ActiveRecord::Base.connection.execute("LOAD DATA INFILE '#{File.join('/tmp', file_name)}' INTO TABLE #{table_name} FIELDS TERMINATED BY '|' IGNORE 1 LINES (PermitType, PermitNo, @date, Address, Mapsco, Contractor, @value, Area, WorkDescription, LandUse) SET Issued = str_to_date(@date, '%m/%d/%Y'),Value = coalesce(nullif(@value, ''),0) ;")
end
activerecord_connect
#IGNORE 2005 b/c Nov & Dec are formatted differently and there is no data until July 2005
#current_date = Date.parse('2005-07-01')
#6.times do 
#	loadfile_4digityear('permit', "#{current_date}.txt")
#	current_date += 1.month
#end
current_date = Date.parse('2006-01-01')
58.times do 
	loadfile('permit', "#{current_date}.txt")
	current_date += 1.month
end
#loadfile('permit', "#{current_date}.txt")
