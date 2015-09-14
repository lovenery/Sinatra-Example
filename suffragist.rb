require 'sinatra'
require 'yaml/store'
=begin
get '/' do
  'Hello, voter!'
end
=end

get '/' do
	@title = 'Welcome to the Suffragist!'
  erb :index
end

=begin
post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote_params']
  erb :cast
end

get '/results' do
  @votes = { 'waw' => 7, 'krk' => 5 }
  erb :results
end
=end

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote_params']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end


Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}