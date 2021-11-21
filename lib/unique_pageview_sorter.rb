# frozen_string_literal: true

# This class is used to sort pageviews by unique visitors
class UniquePageviewSorter
  def self.call
    Countable.group_and_count(:page)
             .reverse_order(:count)
             .to_a
  end
end
