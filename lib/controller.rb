require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show
  end

  post '/gossips/edit/:id' do
    gossip = Gossip.find(params['id'])
    gossip.update(params['new_gossip_author'],params['new_gossip_content'],params['id'])
    redirect "/gossips/#{params['id']}"
  end

  get '/gossips/edit/:id' do
    puts "***************************************edit"
    erb :edit_gossip
  end



end