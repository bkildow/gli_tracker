require 'rubygems'
require 'bundler'

# Require everything in the gems file.
Bundler.require

# Load up environment variables from .env file.
Dotenv.load File.expand_path('.env')

require 'pp'

# Require our app services.
require_relative 'app/services/fetcher'
require_relative 'app/services/elasticsearcher'
require_relative 'app/services/indexer'

module GLI
  class App < Sinatra::Application

    # Sinatra config block.
    configure do
      set :views, 'app/views'
      enable :logging
    end


    # Routes.
    get '/' do
      indexer = GLI::Indexer.new
      indexer.perform

      puts 'hello'

      #erb :index

    end

    # Middleware.
    use Rack::Deflater

  end
end
