require 'spec_helper'
require 'group'

describe Group do
  let(:g) { VCR.use_cassette('group-by-name') { Group.new('Ruby-Slovenia') } }

  it 'works with group url name or ID' do
    g.group.count.must_equal 19
    VCR.use_cassette('group-by-id') do
      Group.new(11453572).group.count.must_equal 19
    end
  end

  it 'has group info' do
    g.group['name'].must_equal 'Slovenia Ruby User Group'
    g.group['members'].must_equal 36
  end

  it 'has upcoming events' do
    VCR.use_cassette('group-by-name-events') do
      g.events.must_be_instance_of Array
      g.events.count.must_equal 4
      g.events.first['name'].must_equal 'Monthly Meetup'
    end
  end

  it 'fails gracefully when group doesnt exist' do
    VCR.use_cassette('group-nonexisting') do
      g = Group.new('aaa')
      g.group['name'].must_equal nil
      g.events.must_be_instance_of Array
      g.events.count.must_equal 0
    end
  end
end
