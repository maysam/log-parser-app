# frozen_string_literal: true

# parses input text into hashtable of urls and their list visitors associated with their visit counts
class Parser
  def initialize(text)
    @lines = text.split("\n")
  end

  def call
    lines.each do |line|
      page, visitor = line.split(' ')
      next unless page && visitor

      view = Countable.where(page: page, visitor: visitor).first
      if view.nil?
        Countable.create(page: page, visitor: visitor, count: 1)
      else
        view.update count: view.count + 1
      end
    end
  end

  private

  attr_accessor :lines
end
