require 'HTTParty'
require 'open-uri'
require 'Nokogiri'
require 'pry'
require_relative 'vulnerability.rb'

# Use when clause to ask user to specify which cve list to get
# ask user for which year

year = "2016" # this will be user input
page = 'https://cve.mitre.org/data/downloads/allitems-cvrf-year-'+year+'.xml'

parse_page = Nokogiri::HTML(open(page))

#Pry.start(binding)
CVE_LIST = {}
parse_page.search('vulnerability').map do |element| 
  CVE_LIST << Vulnerability.new(element.text) 
end

#CVE_LIST = parse_page.css('vulnerability').each

