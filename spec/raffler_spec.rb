require 'spec_helper'
require 'raffler'

describe Raffler do
  let(:r) { Raffler.new }
  it 'has valid meetup client' do
    r.meetup.must_be_instance_of RubyMeetup::ApiKeyClient
  end

  it 'lists RSVPed members of an event' do
    r.rsvps(169771922).must_be_instance_of Array
    r.rsvps(169771922).count.must_equal 17
  end

  it 'lists attending members of an event' do
    r.attending(169771922).must_be_instance_of Array
    r.attending(169771922).count.must_equal 16
  end

  it 'raffles n random attending members of an event' do
    r.raffle(169771922, 2).must_be_instance_of Array
    r.raffle(169771922, 2).count.must_equal 2
  end
end
