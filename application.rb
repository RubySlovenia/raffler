require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'

class Application < Sinatra::Base
  configure do
    $LOAD_PATH << "#{File.dirname(__FILE__)}/lib"
  end

  configure :development do
    register Sinatra::Reloader

    require 'better_errors'
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
    BetterErrors.use_pry!

    require 'dotenv'
    Dotenv.load
  end

  configure :production do
    require 'newrelic_rpm'
  end

  require 'ruby_meetup'
  RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']

  require 'haml'
  require 'group'
  require 'event_raffler'

  get '/' do
    haml :index
  end

  post '/events' do
    json Group.new(params[:name]).events
  end

  get '/event/:id' do
    haml :event, locals: { event: EventRaffler.new(params[:id]) }
  end

  post '/raffle' do
    json EventRaffler.new(params[:event]).raffle(params[:number], params[:reject])
  end
end
