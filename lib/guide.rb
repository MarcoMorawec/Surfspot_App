# Where our Classes live 

require './surfspot'

class Guide

	class Config
		@@actions = ['list', 'find', 'add', 'quit']
		def self.actions; @@actions; end
	end

	def initialize(path=nil)
		# locate the surfspot text file at path
		Surfspot.filepath = path
		if Surfspot.file_usable?
			puts "Found Surfspot file"
		# or create a new file
		elsif Surfspot.create_file
			puts "Created Surfspot file"
		# exit if create fails
		else
			puts "Exiting! \n\n"
			exit!
		end	
	end

	def launch!
		introduction
		# Action loop
		result = nil
		# repeat until user quits (using symbol for quit == :quit)
		until result == :quit
			#   What do you want to do? (list, find, add, quit)?
			action, args= get_action
			#   Do the choosen action
			result = do_action(action, args)
		end
		conclusion
	end

	def get_action
		action = nil
		# Keep asking for user input until we get a valid action
		until Guide::Config.actions.include?(action)
			puts "You can enter: " + Guide::Config.actions.join(", ") if action
			print "> "
			user_response = gets.chomp
			args = user_response.downcase.strip.split(' ')
			#pulling the first word, the action, out of the args array
			action = args.shift
		end
		# if we have an action from our @@actions array, specified in the config class
		return action, args
	end

	def do_action(action, args=[])
		case action
		when 'list'
			list
		when 'find'
			keyword = args.shift
			find(keyword)
		when 'add'
			add
		when 'quit'
			return :quit
		else
			puts 	"\nI don't understand that command.
					\nChoose from \"list\", \"find\", \"add\" OR \"quit\"\n"
		end
	end

	def list
		#outputting the table headline
		output_action_header("List of Surf Spots")
		#getting the restaurants
		surfspot = Surfspot.saved_surfspots
		#outputting the entire table and creating the table content of spot name, location and rating
		output_surfspot_table(surfspot)
	end

	def find(keyword="")
		#showing the same table headline when finding surfspots
		output_action_header("List of Surf Spots")
		#Getting the keyword the user is searching for
		if keyword
			##Search action
			#pulling in all saved susfspots
			surfspot = Surfspot.saved_surfspots
			#matching the keyword to the saved surfspots
			found = surfspot.select do |surf|
				surf.name.downcase.include?(keyword.downcase) ||
				surf.location.downcase.include?(keyword.downcase) ||
				surf.rating.to_i >= keyword.to_i
			end
			#Display the results that are in the found array
			output_surfspot_table(found)
		else
			puts " Find surfspots by entering a surfspot"
			puts " Examples: 'find sunset', 'find mundaka' "
		end
	end

	def add
		puts "Add your Surf Spot details" 
		#create the surfspot, give it its correct value, and save it
		
		#create an instance for surfspot in surfspot.rb
		surfspot = Surfspot.making_surfspot_questions
		

		if surfspot.save
			puts "\nSurf Spot Added\n"
		else
			puts "\nSave Error. Surf Spot not added"
		end
	end


	def introduction
		puts "\n\n<<< Welcome to the Surf Finder >>>\n\n"
		puts "This is an interactive guide to help you find a great surf spot!\n\n"
	end

	def conclusion
		puts "\n<<< Aloha and Happy Surfing! >>>\n\n\n"
	end

	#creating the formatting methods for the table output
	private

	def output_action_header(text)
		puts "\n#{text.upcase.center(60)}\n\n"
	end

	def output_surfspot_table(surfspot=[])
		##Creating the table header
		#Spot name
		print "Spot Name".ljust(20)
		#Spot Location
		print "Spot Location".center(20)
		#Spot Rating
		print "Spot Rating".rjust(20) + "\n"
		#Adding a divider line
		puts "-" * 60
		## Creating the table content
		surfspot.each do |surf|
			line ="" << surf.name.ljust(20)
			line << "" + surf.location.center(20)
			line << "" + surf.rating.rjust(20)
			puts line
		end

		#Showing a message for an empty list
		puts "Surf Spot list is still empty. Try add a Surf Spot" if !Surfspot.file_exists?
		#Adding a divider line
		puts "-" * 60

	end

end
