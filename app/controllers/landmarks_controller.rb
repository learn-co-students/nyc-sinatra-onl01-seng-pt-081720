class LandmarksController < ApplicationController
  
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    if !params[:landmark][:name].empty?
      landmark = Landmark.create(params[:landmark])
      redirect "/landmarks/#{landmark.id}"
    else
      redirect "/landmarks/new"
    end
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end

  
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    if !params[:landmark][:name].empty?
      landmark = Landmark.find_by_id(params[:id])
      landmark.name = params[:landmark][:name]
      if !params[:landmark][:year_completed].empty?
        landmark.year_completed = params[:landmark][:year_completed]
      else
        landmark.year_completed.clear
      end
      landmark.save
      redirect "/landmarks/#{landmark.id}"
    else
      redirect "/landmarks/#{params[:id]}/edit"
    end
  end
end
