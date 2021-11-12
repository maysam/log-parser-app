# frozen_string_literal: true

# This class is used to sort pageviews by unique visitors
class UniquePageviewSorter
  def initialize(views)
    @views = views
  end

  def call
    pageviews.sort { |a, b| b.count <=> a.count }
  end

  private

  attr_accessor :views

  def pageviews
    views.map { |page, visitors| Countable.new page, visitors.count }
  end
end
