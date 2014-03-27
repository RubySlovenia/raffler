require 'ruby_meetup'

class Raffle
  attr_reader :meetup

  def initialize
    RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']
    @meetup = RubyMeetup::ApiKeyClient.new
  end
end
