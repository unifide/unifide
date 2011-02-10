require 'rubygems'
require 'sinatra'

post '/json' do
    response.headers['Content-type'] = 'application/json'
    # might want to use the /json path for AJAX JSON requests
    '{"a":1,"b":"two"}'
end

get '/*' do
    erb :index
end
