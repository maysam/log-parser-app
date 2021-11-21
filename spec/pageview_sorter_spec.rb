# frozen_string_literal: true

require 'spec_helper'
require './lib/pageview_sorter'
require './lib/countable'

RSpec.describe PageviewSorter do
  before do
    Countable.where(Sequel[:count] > 0).delete
  end

  context 'with empty json' do
    it 'sorts into empty array' do
      actuall = described_class.call

      expect(actuall).to eq([]).and be_an(Array)
    end
  end

  context 'with json with one pageview' do
    it 'sorts into array with one pageview' do
      Countable.create(page: '/', visitor: '1.1.1.1', count: 2)

      actuall = described_class.call
      expectation = [
        Countable.new(page: '/', count: 2)
      ]

      expect(actuall).to eq(expectation).and be_an(Array)
    end
  end

  context 'with json with multiple pageviews' do
    it 'sorts into array with one pageview' do
      Countable.create(page: '/a', visitor: '1.1.1.1', count: 1)
      Countable.create(page: '/a', visitor: '1.1.1.2', count: 2)
      Countable.create(page: '/b', visitor: '1.1.1.1', count: 2)
      Countable.create(page: '/b', visitor: '1.1.1.2', count: 3)

      actuall = described_class.call
      expectation = [
        Countable.new(page: '/b', count: 5),
        Countable.new(page: '/a', count: 3)
      ]

      expect(actuall).to eq(expectation).and be_an(Array)
    end
  end
end
