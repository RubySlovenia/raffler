require 'spec_helper'
require 'event_raffler'

describe EventRaffler do
  let(:er) { EventRaffler.new(169771922) }
  it 'has valid meetup client' do
    er.client.must_be_instance_of RubyMeetup::ApiKeyClient
  end

  it 'lists RSVPed members of an event' do
    er.rsvps.must_be_instance_of Array
    er.rsvps.count.must_equal 17
  end

  it 'lists attending members of an event' do
    er.attending.must_be_instance_of Array
    er.attending.count.must_equal 16
  end

  it 'raffles and removes n random attending members of an event' do
    first = er.raffle(2)
    first.must_be_instance_of Array
    first.count.must_equal 2

    second = er.raffle(14)
    second.count.must_equal 14

    third = er.raffle(1)
    third.count.must_equal 0
  end
end
