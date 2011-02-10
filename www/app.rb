require 'rubygems'
require 'sinatra'

get '/' do
    erb :index
end

post '/json' do
    '{"a":1,"b":"two"}'
end
