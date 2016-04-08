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
      
      if @year.to_i < 1999 || @year.to_i > 2016 
       puts "Invalid selection"
       puts # Extra whitespace
       else
        puts "..loading"
        puts
        @scraper = CVE::WebScraper.new
        @scraper.get_page(@year)
        @scraper.create_vulnerabilities
        menu
      end
      
    end

  end

  def menu

    puts <<-DOC
      What would you like to do?
       Please select from the following options:
       1- Search CVE's for a specific month 
       2- Search CVE's for a specific software company
       3- Search CVE's by name
       4- Show all CVE's for the year
       5- Exit"
      DOC
      puts
      @option = gets.strip
      puts

    case @option.to_i
      when 1
        puts "Enter month in 2 digit format please:"
        input = gets.strip
        CVE::VulnerabilityRepo.findByMonth(input)
      when 2
        puts "What would you like to search for?"
        input = gets.strip
        CVE::VulnerabilityRepo.search(input)
      when 3
        puts "What is the name of the CVE? (format CVE-2016-0001)"
        input = gets.strip
        CVE::VulnerabilityRepo.findByName(input)
        puts # For extra whitespace
      when 4
        puts "Here are all the CVE's for the year, brace yourself:"       
        CVE::VulnerabilityRepo.all.each {|x| puts x.text}
      when 5
        abort ("Goodbye!")
      else 
        puts "Invalid selection"
        puts # For extra whitespace
        menu 
      end
  end

end
