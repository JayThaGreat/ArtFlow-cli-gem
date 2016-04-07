require 'HTTParty'
require 'open-uri'
require 'Nokogiri'
require 'pry'
require_relative 'vulnerabilityRepo.rb'

# Use when clause to ask user to specify which cve list to get
# ask user for which year

#year = "2016" # this will be user input
#class Web_Scraper

  @CVE_LIST = []
  year = "2016"
  #def parse(year)
    page = 'https://cve.mitre.org/data/downloads/allitems-cvrf-year-'+year+'.xml'

    parse_page = Nokogiri::HTML(open(page))
    binding.pry
    parse_page.search('vulnerability').map do |element| 
      @CVE_LIST << element.text
    end
  #end

  def create
    @CVE_LIST.each do |attributes|
      VulnerabilityRepo.new(attributes)
    end
  end

#end