class CVE::WebScraper
  # gets used in cli when WebScraper is created
  attr_accessor :year, :document
  
  def initialize(year)
    #initializing with a year so that scraper can get elements from proper page
    @year = year

    #refactored to grab page upon initialization
    @document = Nokogiri::HTML(open('https://cve.mitre.org/data/downloads/allitems-cvrf-year-'+@year+'.xml'))
  end

    #refactored to scrape right from document attribute for webscraper
  def create_vulnerabilities
    @document.search('vulnerability').each do |attributes|
      CVE::Vulnerability.new(attributes)
    end
  end

end