class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    if !params[:figure][:name].empty?
      figure = Figure.new(name: params[:figure][:name])

      if !!params[:figure][:title_ids]
        params[:figure][:title_ids].each do |id| 
          figure.titles << Title.find_by_id(id.to_i)
        end
        figure.titles = figure.titles.uniq
      end

      if !!params[:figure][:landmark_ids]
        params[:figure][:landmark_ids].each do |id| 
          figure.landmarks << Landmark.find_by_id(id.to_i)
        end
        figure.landmarks = figure.landmarks.uniq
      end

      if !!params[:title][:name]
        figure.titles << Title.new(name: params[:title][:name])
      end

      if !!params[:landmark][:name]
        figure.landmarks << Landmark.new(name: params[:landmark][:name])
      end

      figure.save
      redirect "/figures/#{figure.id}"
    else
      redirect '/figures/new'
    end
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end


  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    if !!params[:figure][:name]
      figure = Figure.find_by_id(params[:id])
      figure.name = params[:figure][:name]

      figure.titles.clear
      if !!params[:figure][:title_ids]
        params[:figure][:title_ids].each do |id| 
          figure.titles << Title.find_by_id(id.to_i)
        end
        figure.titles = figure.titles.uniq
      end

      figure.landmarks.clear
      if !!params[:figure][:landmark_ids]
        params[:figure][:landmark_ids].each do |id| 
          figure.landmarks << Landmark.find_by_id(id.to_i)
        end
        figure.landmarks = figure.landmarks.uniq
      end

      if !params[:title][:name].empty?
        figure.titles << Title.new(name: params[:title][:name])
      end

      if !params[:landmark][:name].empty?
        figure.landmarks << Landmark.new(name: params[:landmark][:name])
      end

      figure.save
      redirect "/figures/#{figure.id}"
    else
      redirect "/figures/#{params[:id]}/edit"
    end
  end

end
