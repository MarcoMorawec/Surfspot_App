class Surfspot

	
	@@filepath = nil
	
	#Setting the filepath
	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)
	end


	def self.file_exists?
		#class should know if the restaurant file exists
		File.exist?(file)
	end


	def self.create_file
		#create the surfspots file
		File.new('surfspot.rb', 'w')
	end

	def self.saved_surfspots
		#read the surfspot file
		require 'surfspot.rb'

		#return instances of surfspot
		

end

