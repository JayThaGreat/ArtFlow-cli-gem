class CVE::CLI
  attr_reader :option

  def start
    @option = nil
    
    #create_vulnerabilities
    while @option != ""
      puts "Welcome! Let's get started"
      puts "First tell me which year you would like to look at\nPlease select between 1999 and 2016:\n (Anything prior to 1999 means you're probably outta luck and compromised :-( ))"
      year = gets.strip 
      
      if valid_year?(year.to_i)
        puts "..loading"
        puts
        scraper = CVE::WebScraper.new(year)
        #scraper.year = year.to_i # setting the year in the new scraper
        scraper.create_vulnerabilities
        menu
       else
        puts "Invalid selection"
        puts # Extra whitespace
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
       5- Select a different year
       6- Exit"
      DOC
      puts
      @option = gets.strip
      puts

    case @option.to_i
      when 1
        puts "Enter month in 2 digit format please:"
        input = gets.strip
        CVE::Vulnerability.findByMonth(input)
      when 2
        puts "What would you like to search for?"
        input = gets.strip
        CVE::Vulnerability.search(input)
      when 3
        puts "What is the name of the CVE? (format CVE-2016-0001)"
        input = gets.strip
        CVE::Vulnerability.findByName(input)
        puts # For extra whitespace
      when 4
        puts "Here are all the CVE's for the year, brace yourself:"       
        CVE::Vulnerability.all.each {|x| puts x.text}
      when 5
        puts # Extra whitespace
        puts "Selecting another year"
        start
      when 6
        abort ("Goodbye!")
      else 
        puts "Invalid selection"
        puts # For extra whitespace
        menu 
      end
  end

  def valid_year?(year)
    year <= 2016 && year >= 1999
  end

end
