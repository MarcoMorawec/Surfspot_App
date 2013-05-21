# Where our Classes live 

require './surfspot'

class Guide

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
		loop do 
			#   What do you want to do? (list, find, add, quit)?
			print "> "
			user_response = gets.chomp
			#   Do the choosen action
			result = do_action(user_response)
			# repeat until user quits (using symbol for quit == :quit)
			break if result == :quit
		end
		conclusion
	end

	def do_action(action)
		case action
		when 'list'
			puts "Listing ..."
		when 'find'
			puts "finding ..."
		when 'add'
			puts "adding ..."
		when 'quit'
			return :quit
		else
			puts 	"\nI don't understand that command.
					\nChoose from \"list\", \"find\", add OR \"quit\"\n"
		end
	end


	def introduction
		puts "\n\n<<< Welcome to the Surf Finder >>>\n\n"
		puts "This is an interactive guide to help you find a great surf spot!\n\n"
	end

	def conclusion
		puts "\n<<< Aloha and Happy Surfing! >>>\n\n\n"
	end


end
