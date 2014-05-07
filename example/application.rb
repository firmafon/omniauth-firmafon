=begin
omniauth-firmafon example
First go to https://app.firmafon.dk/developers to register for
a developer account and create an app to get the keys that are needed.
For further development with the Firmafon API, visit the full
documentation at http://firmafon.github.io
=end

require 'sinatra'
require 'omniauth-firmafon'

use Rack::Session::Cookie, :key => 'rack.session',
  :expire_after => 60 * 60 * 24 * 365, # one year in seconds
  :secret => '_nbDlHipuHjPaXk02IsYAP!US' # random string

use OmniAuth::Builder do
  provider :firmafon,
    # These are keys from the example app. Substitute with your own.
    '1d07f2b483b4c9ea31d534302e3ffaac37fc6966f1eee32c9c28f8c2bb086ded',
    'd5a85b3476c12398fb930944770a6a32d5015fe24dd61c8d8aff14b9825d1094',
    redirect_uri: 'http://localhost:9292/'
end

helpers do
  def current_user
    !!session[:user_id]
  end
  def authenticate!
    redirect '/' unless current_user
  end
end

get '/' do
  if current_user
    "We are in!"
  else
    "<a href='/auth/firmafon'>Authenticate with Firmafon</a>"
  end
end

get '/auth/firmafon/callback' do
  auth = env['omniauth.auth']
  session[:user_id] = auth['info']['id']
  redirect '/'
end

get '/auth/failure' do
  "Failure"
end

get '/sign_out' do
  session[:user_id] = nil
  redirect '/'
end
