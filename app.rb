require 'sinatra'
require 'haml'

set :sessions, httponly: true, secure: true, expire_after: 600, secret: "hunter2"

get '/' do
  if session[:exists].nil?
    haml :new
  elsif session[:pwned]
    haml :pwned
  else
    haml :normal
end

post '/reset' do
  session.clear
  session[:exists] = true
  session[:pwned] = false
end
