# frozen_string_literal: true

require 'spec_helper'
require './lib/unique_pageview_sorter'
require './lib/countable'

RSpec.describe UniquePageviewSorter do
  context 'with empty json' do
    it 'sorts into empty array' do
      actuall = described_class.new({}).call

      expect(actuall).to eq([]).and be_an(Array)
    end
  end

  context 'with json with one pageview' do
    it 'sorts into array with one pageview' do
      json = {
        '/' => {
          '1.1.1.1' => 2
        }
      }
      actuall = described_class.new(json).call
      expectation = [
        Countable.new('/', 1)
      ]

      expect(actuall).to be_an(Array)
      expect(actuall[0].as_json).to eq(expectation[0].as_json)
    end
  end

  context 'with json with multiple pageviews' do
    it 'sorts into array with one pageview' do
      json = {
        '/a' => {
          '1.1.1.1' => 1,
          '1.1.1.2' => 1,
          '1.1.1.3' => 2
        },
        '/b' => {
          '1.1.1.1' => 2,
          '1.1.1.2' => 3
        }
      }
      actuall = described_class.new(json).call
      expectation = [
        Countable.new('/a', 3),
        Countable.new('/b', 2)
      ]

      expect(actuall).to be_an(Array)
      expect(actuall[0].as_json).to eq(expectation[0].as_json)
    end
  end
end
