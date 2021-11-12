# frozen_string_literal: true

# This class is used to sort pageviews by number of visitors
class PageviewSorter
  def initialize(views)
    @views = views
  end

  def call
    pageviews.sort { |a, b| b.count <=> a.count }
  end

  private

  attr_accessor :views

  def pageviews
    views.map { |page, visitors| Countable.new page, visitors.values.sum }
  end
end
