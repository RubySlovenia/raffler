require 'spec_helper'
require 'event_raffler'

describe EventRaffler do
  let(:r) { EventRaffler.new(169771922) }
  it 'has valid meetup client' do
    r.client.must_be_instance_of RubyMeetup::ApiKeyClient
  end

  it 'lists RSVPed members of an event' do
    r.rsvps.must_be_instance_of Array
    r.rsvps.count.must_equal 17
  end

  it 'lists attending members of an event' do
    r.attending.must_be_instance_of Array
    r.attending.count.must_equal 16
  end

  it 'raffles n random attending members of an event' do
    first = r.raffle(2)
    first.must_be_instance_of Array
    first.count.must_equal 2
  end
end
