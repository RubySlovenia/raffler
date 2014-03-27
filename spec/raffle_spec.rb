require 'spec_helper'
require 'raffle'

describe Raffle do
  let(:r) { Raffle.new }
  it 'has valid meetup client' do
    r.meetup.must_be_instance_of RubyMeetup::ApiKeyClient
  end
end
