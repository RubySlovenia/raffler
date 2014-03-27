require 'ruby_meetup'
require 'json'

class Group
  attr_reader :group

  def initialize(name_or_id)
    RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']
    @client = RubyMeetup::ApiKeyClient.new
    @group = get_group(name_or_id)['results'].first
  end

  def events
    @events ||= get_events['results']
  end

  private
  def get_group(name_or_id)
    if name_or_id.to_i > 0
      JSON.parse(@client.get_path('/2/groups', { group_id: name_or_id }))
    else
      JSON.parse(@client.get_path('/2/groups', { group_urlname: name_or_id }))
    end
  end

  def get_events
    JSON.parse(@client.get_path('/2/events', { group_id: @group['id'] }))
  end
end
