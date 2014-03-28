require 'spec_helper'
require 'event_raffler'

describe EventRaffler do
  let(:er) { EventRaffler.new(169771922) }

  it 'has its own id' do
    er.event_id.must_equal 169771922
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
      er.attending.first['member']['name'].must_equal 'Miha Rekar'
    end
  end

  it 'raffles n random attending members' do
    VCR.use_cassette('event-169771922') do
      er.raffle(2).must_be_instance_of Array
      er.raffle(2).count.must_equal 2
      er.raffle('2').count.must_equal 2
      er.raffle('2', nil).count.must_equal 2
    end
  end

  it 'raffles n random attending members without particular members' do
    VCR.use_cassette('event-169771922') do
      reject = [14137286, '6241033', 3436854, 127066762, 6250861, 35761952]
      second = er.raffle(16, reject)
      second.count.must_equal 10
    end
  end
end
