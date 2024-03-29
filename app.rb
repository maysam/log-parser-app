#!/usr/bin/env ruby
# frozen_string_literal: true

require './db'
require './lib/countable'
require './lib/parser'
require './lib/pageview_sorter'
require './lib/unique_pageview_sorter'

if ARGV.empty?
  puts 'Please provide input file name'
  exit
end

filename = ARGV[0]

unless File.exist?(filename)
  puts "File #{filename} does not exist"
  exit
end

puts "Parsing file #{filename}"
Parser.new(filename).call

sorted_pageviews = PageviewSorter.call
print "Pageview count per page sorted by descending order:\n\n"
sorted_pageviews.each { |url| pp "#{url.page} #{url.count} visits" }
print "\n"

sorted_unique_pageviews = UniquePageviewSorter.call
print "Unique Pageview count per page sorted by descending order:\n\n"
sorted_unique_pageviews.each { |url| pp "#{url.page} #{url.count} unique views" }
print "\n"
