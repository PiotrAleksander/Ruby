require 'spec_helper'

describe Xo do
  it 'posiada numer wersji' do
    expect(Xo::VERSION).not_to be nil
  end

  it 'jest uzyteczny' do
    expect(false).to eq(true)
  end
end
