class Title < ActiveRecord::Base
  # add relationships here
  has_many :figures, through: :figure_titles 
end
