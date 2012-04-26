require 'rubygems'
require 'sinatra'

class DumbererApp < Sinatra::Base

  # the main endpoint for scm services
  post '/' do
    puts "Handling ping for #{credentials.inspect}"
    puts data
    puts "Request created : #{payload.inspect}"
    204
  end

  protected

  def data
    {
      :type => event_type,
      :credentials => credentials,
      :request => payload
    }
  end

  def event_type
    env['HTTP_X_GITHUB_EVENT'] || 'UNKNOWN'
  end

  def credentials
    login, token = Rack::Auth::Basic::Request.new(env).credentials
    { :login => login, :token => token }
  end

  def payload
    params[:payload]
  end
end
