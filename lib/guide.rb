# Where our Classes live 

class Guide

	def initialize(path=nil)
		# locate the surfspot text file at path
		# or create a new file
		# exit if create fails
	end

	def launch!
		introduction
		# Action loop
		#   What do you want to do? (list, find, add, quit)?
		#   Do the choosen action
		# repeat until user quits
		conclusion
	end

	def introduction
		puts "\n\n<<< Welcome to the Surf Finder >>>\n\n"
		puts "This is an interactive guide to help you find a great surf spot\n\n"
	end

	def conclusion
		puts "\n<<< Aloha and Happy Surfing! >>>\n\n\n"
	end


end
