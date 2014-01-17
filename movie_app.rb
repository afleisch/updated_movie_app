require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get "/" do 
    erb :index	
end

post "/result" do #send the information enter into search and return it to /result page

search_str = params[:movie]
response = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str})

@initial_movie_array = JSON.parse(response.body)["Search"]
erb :result

end

post '/test' do

  search_str = params[:movie]
  response = Typhoeus.get("www.omdbapi.com", :params => {s: search_str})
  movies = JSON.parse(response.body)["Search"]

end

get '/movieinfo/:imdb' do |imdb_id|
  # Make another api call here to get the url of the poster.
  response = Typhoeus.get("www.omdbapi.com", :params => {i: imdb_id})
  @movieinfo = JSON.parse(response.body)
 

  erb :movieinfo

end