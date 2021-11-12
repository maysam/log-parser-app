# frozen_string_literal: true

# parses input text into hashtable of urls and their list visitors associated with their visit counts
class Parser
  def initialize(text)
    @lines = text.split("\n")
  end

  def call
    views = {}
    lines.each do |line|
      page, visitor = line.split(' ')
      next unless page && visitor

      views[page] ||= {}
      views[page][visitor] ||= 0
      views[page][visitor] += 1
    end
    views
  end

  private

  attr_accessor :lines
end
