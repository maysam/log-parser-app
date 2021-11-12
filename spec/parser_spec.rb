# frozen_string_literal: true

require 'spec_helper'
require './lib/parser'

RSpec.describe Parser do
  context 'with empty string' do
    it 'parses into an empty hash' do
      actuall = described_class.new('').call

      expect(actuall).to eq({})
    end
  end

  context 'with badformatted input' do
    it 'ignores lines with no visitor info' do
      input_text = <<~HEREDOC
        page1 visitor1
        page2

      HEREDOC

      actuall = described_class.new(input_text).call

      expect(actuall).to eq({ 'page1' => { 'visitor1' => 1 } })
    end
  end

  context 'with well-formatted input' do
    it 'sums up repeated visitors' do
      input_text = <<~HEREDOC
        page1 visitor1
        page2 visitor1
        page1 visitor2
        page2 visitor2

        page1 visitor1
        page1 visitor1
        page2 visitor2

      HEREDOC

      actuall = described_class.new(input_text).call

      expect(actuall).to eq({
                              'page1' => { 'visitor1' => 3, 'visitor2' => 1 },
                              'page2' => { 'visitor1' => 1, 'visitor2' => 2 }
                            })
    end
  end
end
