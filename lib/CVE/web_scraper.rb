require 'HTTParty'
require 'open-uri'
require 'Nokogiri'
require 'pry'
require_relative 'vulnerabilityRepo.rb'

# Use when clause to ask user to specify which cve list to get
# ask user for which year

year = "2016" # this will be user input
page = 'https://cve.mitre.org/data/downloads/allitems-cvrf-year-'+year+'.xml'

parse_page = Nokogiri::HTML(open(page))

@CVE_LIST = []
parse_page.search('vulnerability').map do |element| 
  @CVE_LIST << element.text
end

@CVE_LIST.each do |attributes|
  VulnerabilityRepo.new(attributes)
end

#@CVE_LIST[:vulnerabilities].children.text to return entire vulnerability

#time can't you believe what's become of us
#Can't judge but sometimes the people who choose to be in our lives
#just cant. While those who have the opportunity don't