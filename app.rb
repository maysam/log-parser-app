#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/countable'
require './lib/parser'
require './lib/pageview_sorter'
require './lib/unique_pageview_sorter'

lines = File.open(ARGV[0]).read

views = Parser.new(lines).call

sorted_pageviews = PageviewSorter.new(views).call
print "Pageview count per page sorted by descending order:\n\n"
sorted_pageviews.each { |url| pp "#{url.page} #{url.count} visits" }
print "\n"

sorted_unique_pageviews = UniquePageviewSorter.new(views).call
print "Unique Pageview count per page sorted by descending order:\n\n"
sorted_unique_pageviews.each { |url| pp "#{url.page} #{url.count} unique views" }
print "\n"
