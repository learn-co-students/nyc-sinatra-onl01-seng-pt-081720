class LandmarksController < ApplicationController

  #Index 
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  #New
  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    landmark = Landmark.new
    landmark.name = params[:name]
    landmark.year_completed = params[:year_completed]
    landmark.save
    redirect to "landmarks/#{landmark.id}"
  end

  #Show
  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end

  #Edit/Update
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    landmark = Landmark.find_by_id(params[:id])
    landmark.update(params[:landmark])
    landmark.save
    redirect to "/landmarks/#{landmark.id}"
  end

end
