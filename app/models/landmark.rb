class Landmark < ActiveRecord::Base
  # add relationships here
  has_many :landmarks
  belongs_to :figure
end
