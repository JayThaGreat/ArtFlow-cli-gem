class CVE::CLI
  attr_reader :year

  def call
    start
  end

  def start
    option = nil
    while option != ""

      puts "Welcome! Let's get started"
      puts "First tell me which year you would like to look at\n Please select between 1999 and 2016:\n (Anything prior to 1999 means you're probably outta luck and compromised :-( ))"
      @year = gets.strip

      menu

      option = input.gets
      
      #put case below in menu
      case true
      when option == "1"
        puts "Enter month in 2 digit format please:"
        month = input.gets
      when option == "2"
        puts "What would you like to search for?"
        text = input.gets
      when option == "3"
        puts "What is the name of the CVE? (format CVE-2016-0001)"
        cve = input.gets
      when option == "4"
        puts "Here are all the CVE's for the year, brace yourself:"       
        # call all method for VulnerabilityRepo
      when option == "5"
        puts "Goodbye!"
      else 
        puts "Invalid selection"
        end
      end
    end

  end

  def menu
    puts <<-DOC
      "What would you like to do?"
       "Please select from the following options:"
       "1- Search CVE's for a specific month" # indicate option that 
       "2- Search CVE's for a specific software company"
       "3- Search CVEs by name"
       "4- Show all CVE's for the year"
       "5- Exit"
      DOC
    end

end
      