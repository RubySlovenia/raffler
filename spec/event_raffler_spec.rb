require 'spec_helper'
require 'event_raffler'

describe EventRaffler do
  let(:er) { EventRaffler.new(169771922) }
  it 'has valid meetup client' do
    er.client.must_be_instance_of RubyMeetup::ApiKeyClient
  end

  it 'lists RSVPed members of an event' do
    VCR.use_cassette('event-169771922') do
      er.rsvps.must_be_instance_of Array
      er.rsvps.count.must_equal 17
    end
  end

  it 'lists attending members of an event' do
    VCR.use_cassette('event-169771922') do
      er.attending.must_be_instance_of Array
      er.attending.count.must_equal 16
    end
  end

  it 'raffles and removes n random attending members of an event' do
    VCR.use_cassette('event-169771922') do
      first = er.raffle(2)
      first.must_be_instance_of Array
      first.count.must_equal 2

      second = er.raffle(14, first)
      second.count.must_equal 14

      third = er.raffle(1, first + second)
      third.count.must_equal 0
    end
  end
end
