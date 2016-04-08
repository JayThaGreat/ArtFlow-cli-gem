class CVE::WebScraper
  # gets used in cli when WebScraper is created
  attr_reader :year
  
  def get_page(year)
    @year = year
    Nokogiri::HTML(open('https://cve.mitre.org/data/downloads/allitems-cvrf-year-'+year+'.xml'))
  end

  def scrape_cves
    self.get_page(@year).search('vulnerability')
  end

  def create_vulnerabilities
    scrape_cves.each do |attributes|
      CVE::VulnerabilityRepo.new_from_page(attributes)
    end
  end

end