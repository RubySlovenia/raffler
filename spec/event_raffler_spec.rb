require 'spec_helper'
require 'event_raffler'

describe EventRaffler do
  let(:er) { EventRaffler.new(169771922) }

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

  it 'raffles n random attending members' do
    VCR.use_cassette('event-169771922') do
      er.raffle(2).must_be_instance_of Array
      er.raffle(2).count.must_equal 2
    end
  end

  it 'raffles n random attending members without particular members' do
    VCR.use_cassette('event-169771922') do
      first = er.raffle(16)
      first.count.must_equal 16

      second = er.raffle(1, first)
      second.count.must_equal 0
    end
  end
end
