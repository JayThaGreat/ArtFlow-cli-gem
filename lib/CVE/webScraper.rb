#require 'HTTParty'
#require 'open-uri'
#require 'Nokogiri'
#require 'pry'

#require_relative './version'
#require_relative 'vulnerabilityRepo.rb'

# Use when clause to ask user to specify which cve list to get
# ask user for which year

class CVE::WebScraper
  @CVE_LIST = []
  attr_reader :year
  # gets used in cli when WebScraper is created
  def get_page(year)
    @year = year
    Nokogiri::HTML(open('https://cve.mitre.org/data/downloads/allitems-cvrf-year-'+year+'.xml'))
  end

  def scrape_cves
    #container = []
    self.get_page(@year).search('vulnerability')#.map do |element| 
      #container << element.text
   # end

   # @CVE_LIST = container
   # binding.pry
  end

  def create_vulnerabilities
    scrape_cves.each do |attributes|
    #@CVE_LIST.each do |attributes|
      CVE::VulnerabilityRepo.new_from_page(attributes)
      #VulnerabilityRepo.new(attributes)
    end
  end

end