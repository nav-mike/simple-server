require_relative './services/create_user'

require 'webrick'

module Server
  extend self

  def call(host, port)
    @app = Rack::Builder.new do
      map '/user' do
        run CreateUser
      end
      map '/' do
        run lambda { |_| [200, {'Content-Type' => 'text/html'}, ['Hello World']] }
      end
    end

    Rack::Handler::WEBrick.run(@app, Host: host, Port: port)

    Signal.trap('INT') { Rack::Handler::WEBrick.shutdown }
  end
end
