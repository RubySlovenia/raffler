require 'ruby_meetup'
require 'json'

class EventRaffler
  def initialize(event_id)
    @client = RubyMeetup::ApiKeyClient.new
    @event_id = event_id
  end

  def rsvps
    @rsvps ||= get_rsvps_json['results']
  end

  def attending
    rsvps.reject{ |m| m['response'] == 'no'  }
  end

  def raffle(n, reject = [])
    pot(reject).sample(n)
  end

  private
  def get_rsvps_json
    JSON.parse(@client.get_path('/2/rsvps', { event_id: @event_id }))
  end

  def pot(reject)
    attending.reject{ |m| reject.include? m['member']['member_id'] }
  end
end
