require 'sinatra'
require 'magnum/payload'

class MyApp < Sinatra::Base
  post '/payload/:provider' do
    payload = Magnum::Payload.parse(
      params[:provider],
      params[:payload]
    )

    "I got some json: #{payload.attributes_hash.inspect}"
  end
end