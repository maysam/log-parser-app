# frozen_string_literal: true

require 'spec_helper'
require './lib/parser'
require './lib/countable'

RSpec.describe Parser do
  before do
    Countable.where(Sequel[:count] > 0).delete
  end

  context 'with empty string' do
    it 'parses into an empty hash' do
      described_class.new('spec/fixtures/empty.log').call

      expect(Countable.count).to eq 0
    end
  end

  context 'with badformatted input' do
    it 'ignores lines with no visitor info' do
      described_class.new('spec/fixtures/badfile.log').call

      expect(Countable.where(page: 'page1', visitor: 'visitor1', count: 1).count).to eq 1
    end
  end

  context 'with well-formatted input' do
    it 'sums up repeated visitors' do
      described_class.new('spec/fixtures/multivisitor.log').call

      expect(Countable.where(page: 'page1', visitor: 'visitor1', count: 3).count).to eq 1
      expect(Countable.where(page: 'page1', visitor: 'visitor2', count: 1).count).to eq 1
      expect(Countable.where(page: 'page2', visitor: 'visitor1', count: 1).count).to eq 1
      expect(Countable.where(page: 'page2', visitor: 'visitor2', count: 2).count).to eq 1
      expect(Countable.count).to eq 4
    end
  end
end
