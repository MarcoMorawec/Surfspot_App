class Surfspot

	
	@@filepath = nil

	#Setting the filepath
	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)
	end

	attr_accessor :name, :location, :rating


	def self.file_exists?
		#class should know if the surfspot file exists
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false		
		end
	end

	def self.file_usable?
		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
	end

	def self.create_file
		#create the surfspots file
		File.open(@@filepath, 'w') unless file_exists?
		return file_usable?
	end

	def self.saved_surfspots
		#read the surfspot file
		require 'surfspots.txt'

		#return instances of surfspot
	end

	def self.making_surfspot_questions
		args={}

		#passing the arguments into the method
		print "Add Surf Spot name:"
		args[:name] = gets.chomp.strip
		
		print "Add Surf Spot location:"
		args[:location] = gets.chomp.strip
		
		print "Add Surf Spot Rating (1-5):"
		args[:rating] = gets.chomp.strip

		surfspot = self.new(args)
	end

	#initialize surfspots
	def initialize(args={})
		@name     = args[:name]     || ""
		@location = args[:location] || ""
		@rating   = args[:rating]   || ""
	end


	def save
		return false unless Surfspot.file_usable?
		File.open(@@filepath, 'a') do |file|
			file.puts "#{[@name, @location, @rating].join("\t")}\n"
		end
		return true
	end

end

