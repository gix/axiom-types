# encoding: utf-8

require 'spec_helper'

describe Axiom::Types::Boolean, '.infer' do
  subject { object.infer(arg) }

  let(:object) { described_class }

  context 'when the argument is the type object' do
    let(:arg) { object }

    it { should be(object) }
  end

  context 'when the argument is ::TrueClass' do
    let(:arg) { ::TrueClass }

    it { should be(object) }
  end

  context 'when the argument is ::FalseClass' do
    let(:arg) { ::FalseClass }

    it { should be(object) }
  end
end
