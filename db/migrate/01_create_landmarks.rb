class CreateLandmarks < ActiveRecord::Migration
  #raise 'Write CreateLandmarks migration here'

  def change
    create_table :landmarks do |t|
      t.string :name
      t.string :year_completed
    end
  end
end
