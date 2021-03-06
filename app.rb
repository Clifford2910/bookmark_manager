require 'sinatra/base'
require './lib/bookmark'
require 'pg'

class Bookmark_Manager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    "Bookmark Manager"
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks/new' do
    Bookmark.create(url: params['url'], title: params['title'])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
