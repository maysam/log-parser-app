# frozen_string_literal: true

# parses input text into hashtable of urls and their list visitors associated with their visit counts
class Parser
  def initialize(filename)
    @filename = filename
  end

  def call
    File.open(filename, 'r').each_line do |line|
      page, visitor = line.split(' ')
      next unless page && visitor

      row = Countable.where(page: page, visitor: visitor).first
      if row.nil?
        Countable.create(page: page, visitor: visitor, count: 1)
      else
        row.update count: row.count + 1
      end
    end
  end

  private

  attr_accessor :filename
end
