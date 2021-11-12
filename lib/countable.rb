# frozen_string_literal: true

# associates the number of counts with each page
class Countable
  def initialize(page, count)
    @page = page
    @count = count
  end

  def as_json
    {
      page: page,
      count: count
    }
  end

  attr_accessor :page, :count
end
