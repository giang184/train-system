require 'sinatra'
require 'sinatra/reloader'
require('./lib/city')
require('./lib/train')
also_reload 'lib/**/*.rb'
require 'pry'
require "pg"

DB = PG.connect({ dbname: 'train_system', host: 'db', user: 'postgres', password: 'password' })

get '/' do
  redirect to('/trains')
end

get ('/trains') do
  @trains = Train.all
  erb(:trains)
end

get ('/cities') do
  @cities = City.all
  erb(:cities)
end

get ('/trains/new') do
  erb(:new_train)
end

post ('/trains') do
  name = params[:train_name]
  train = Train.new({:name => name, :id => nil})
  train.save
  redirect to('/trains')
end

get ('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  erb(:train)
end

get ('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

post ('/trains/:id/cities') do
  @train = Train.find(params[:id].to_i())
  city = City.new({:name => params[:city_name], :id => nil})
  city.save()
  city.link(@train.id, params[:boarding_time].to_s())
  erb(:train)
end

get ('/trains/:id/cities/:city_id') do
  @city = City.find(params[:city_id].to_i())
  redirect to ("/cities/#{params[:city_id].to_i()}")
end

patch ('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.update(params[:name])
  redirect to('/trains')
end

delete ('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.delete()
  redirect to('/trains')
end

get ('/trains/:id') do
  redirect to("/trains/#{params[:id].to_i()}")
end

get ('/cities/:id/edit') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
end

patch ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.update({:name => params[:name]})
  redirect to('/cities')
end

delete ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  redirect to('/cities')
end

get ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  erb(:city)
end


post ('/cities/:id/trains') do
  @city = City.find(params[:id].to_i())
  train = Train.new({:name => params[:train_name], :id => nil})
  train.save()
  @city.link(train.id, params[:boarding_time].to_s())
  erb(:city)
end
