class Surfspot

	
	@@filepath = nil

	#Setting the filepath
	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)
	end


	def self.file_exists?
		#class should know if the surfspot file exists
		File.exist?('surfspot.txt')
	end


	def self.create_file
		#create the surfspots file
		File.new('surfspot.txt', 'w')
	end

	def self.saved_surfspots
		#read the surfspot file
		require 'surfspot.txt'

		#return instances of surfspot
	end

end

