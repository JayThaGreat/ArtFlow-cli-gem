require 'HTTParty'
require 'open-uri'
require 'Nokogiri'
require 'pry'
#require_relative 'vulnerability.rb'

# Use when clause to ask user to specify which cve list to get
# ask user for which year

year = "2016" # this will be user input
page = 'https://cve.mitre.org/data/downloads/allitems-cvrf-year-'+year+'.xml'

parse_page = Nokogiri::HTML(open(page))

@CVE_LIST = {}
parse_page.search('vulnerability').each do |element| 
  @CVE_LIST[:vulnerabilities] = element
  #binding.pry
end

@CVE_LIST[:vulnerabilities].each do |attributes|
  Vulnerability.new(attributes)
end