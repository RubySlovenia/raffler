require 'ruby_meetup'
require 'json'

class Raffler
  attr_reader :meetup

  def initialize
    RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']
    @meetup = RubyMeetup::ApiKeyClient.new
  end

  def rsvps(event_id)
    rsvps = JSON.parse(@meetup.get_path('/2/rsvps', { event_id: event_id }))
    rsvps['results']
  end

  def attending(event_id)
    rsvps(event_id).reject{ |r| r['response'] != 'yes'  }
  end

  def raffle(event_id, n)
    attending(event_id).sample(n)
  end
end
