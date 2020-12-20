class Figure < ActiveRecord::Base
  # add relationships here
  has_many :landmarks
  has_many :titles
  has_many :figure_titles, through: :figures
end
