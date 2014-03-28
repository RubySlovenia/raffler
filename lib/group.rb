require 'json'

class Group
  attr_reader :group

  def initialize(name_or_id)
    @client = RubyMeetup::ApiKeyClient.new
    @group = get_group(name_or_id)
  end

  def events
    @events ||= get_events.sort_by{ |e| e['time'] }.reverse
  end

  private
  def get_group(name_or_id)
    if name_or_id.to_i > 0
      r = @client.get_path('/2/groups', { group_id: name_or_id })
    else
      r = @client.get_path('/2/groups', { group_urlname: name_or_id })
    end
    JSON.parse(r)['results'].first || {}
  end

  def get_events
    if @group['id']
      JSON.parse(@client.get_path('/2/events', { group_id: @group['id'], status: 'upcoming,past' }))['results']
    else
      []
    end
  end
end
