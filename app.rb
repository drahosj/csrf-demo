require 'sinatra'
require 'haml'
require 'encrypted_cookie'

use Rack::Session::EncryptedCookie, 
  httponly: false,
  path: '/',
  secret: 'hunter2hunter2hunter2hunter2'

get '/' do
  if session[:exists].nil?
    haml :new
  elsif session[:pwned]
    haml :pwned
  else
    haml :normal
  end
end

get '/submit' do
  if params[:pwned] == "yes"
    session[:pwned] = true
  end

  redirect to '/'
end

post '/reset' do
  session.clear
  session[:exists] = true
  session[:pwned] = false

  redirect to '/'
end
