require 'spec_helper'
require 'raffle'

describe Raffle do
  let(:r) { Raffle.new }
  it 'has valid meetup client' do
    r.meetup.must_be_instance_of RubyMeetup::ApiKeyClient
  end

  it 'lists RSVPed members of an event' do
    r.rsvps(169771922).must_be_instance_of Array
    r.rsvps(169771922).count.must_equal 17
  end
end
