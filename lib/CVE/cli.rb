#require_relative 'vulnerabilityRepo'

class CVE::CLI
  attr_reader :year, :option
  @scraper


  def call
    start
  end

  def start
    @option = nil
    
    #create_vulnerabilities
    while @option != ""
      puts "Welcome! Let's get started"
      puts "First tell me which year you would like to look at\nPlease select between 1999 and 2016:\n (Anything prior to 1999 means you're probably outta luck and compromised :-( ))"
      @year = gets.strip

      @scraper = CVE::WebScraper.new
      #binding.pry
      @scraper.get_page(@year)
      @scraper.create_vulnerabilities

      #@object = VulnerabilityRepo.new
      #@object.parse(@year)
      #@object.create

      menu
      #@option = input.gets
      #put case below in menu
    end

  end

  def menu
    #input = nil
    puts <<-DOC
      "What would you like to do?"
       "Please select from the following @options:"
       "1- Search CVE's for a specific month" # indicate @option that 
       "2- Search CVE's for a specific software company"
       "3- Search CVEs by name"
       "4- Show all CVE's for the year"
       "5- Exit"
      DOC
      @option = gets.strip

    case true
      when @option == "1"
        puts "Enter month in 2 digit format please:"
        month = gets.strip
        CVE::VulnerabilityRepo.findByMonth(month)
      when @option == "2"
        puts "What would you like to search for?"
        text = gets.strip
        CVE::VulnerabilityRepo.search(text)
      when @option == "3"
        puts "What is the name of the CVE? (format CVE-2016-0001)"
        cve = gets.strip
        CVE::VulnerabilityRepo.findByName(cve)
      when @option == "4"
        puts "Here are all the CVE's for the year, brace yourself:"       
        # call all method for VulnerabilityRepo
        CVE::VulnerabilityRepo.all
      when @option == "5"
        puts "Goodbye!"
      else 
        puts "Invalid selection"
      end
  end

end
