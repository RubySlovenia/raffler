require 'ruby_meetup'
require 'json'

class EventRaffler
  attr_reader :event_id

  def initialize(event_id)
    @client = RubyMeetup::ApiKeyClient.new
    @event_id = event_id
  end

  def rsvps
    @rsvps ||= get_rsvps_json['results']
  end

  def attending
    rsvps.select{ |m| m['response'] == 'yes' }.sort_by{ |m| m['mtime'] }
  end

  def raffle(n, reject = [])
    pot(reject).sample(n.to_i)
  end

  private
  def get_rsvps_json
    JSON.parse(@client.get_path('/2/rsvps', { event_id: @event_id }))
  end

  def pot(reject)
    reject = reject.to_a.map(&:to_i)
    attending.reject{ |m| reject.include? m['member']['member_id'] }
  end
end
