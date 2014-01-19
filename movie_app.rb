require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

get '/' do #at the home page, render code in index.erb 
#i.e form to enter search paramters
    erb :index	
end

post '/result' do #send the information entered into search 
#and return it to /result page via result.erb

	search_str = params[:movie]
	response = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str})
	binding.pry
	@initial_data = JSON.parse(response.body)
	if @initial_data['Response'] == "False"
		redirect "/"
	else
	@movie_array_of_hashes = @initial_data["Search"]
	@just_movies =[]
	@movie_array_of_hashes.select do |movie_hash|
		if movie_hash["Type"] == "movie"
			@just_movies << movie_hash
		end
	  end
	end

	erb :result
end

get '/poster/:imdb' do |imdb_id| #get list of information from api 
#request based on search parameter equal to imdb_id and display it to
#/movieinfo page via movieinfo.erb
 
  response = Typhoeus.get("www.omdbapi.com", :params => {i: imdb_id})
  @movieinfo = JSON.parse(response.body)

  erb :poster

end