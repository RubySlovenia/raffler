require 'sinatra/base'

class Application < Sinatra::Base
  configure :production do
    require 'newrelic_rpm'
  end

  require 'haml'

  get '/' do
    haml :index
  end
end
