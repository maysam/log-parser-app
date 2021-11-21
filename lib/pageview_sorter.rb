# frozen_string_literal: true

# This class is used to sort pageviews by number of visitors
class PageviewSorter
  def self.call
    Countable.select(:page)
             .select_more { sum(:count).as(:count) }
             .group(:page)
             .reverse_order(:count)
             .to_a
  end
end
