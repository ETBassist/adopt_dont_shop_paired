class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy

  def self.sorted_by(param)
    if param == "adoptable"
      # TODO: Refactor with ActiveRecord
      # Shelter.joins(:pets).group(:id).order(pets.count(:adoptable))
      Shelter.all.sort_by do |shelter|
        shelter.pets.count(:adoptable)
      end.reverse
    elsif param == "alphabetical"
      Shelter.order(:name)
    else
      Shelter.all
    end
  end
end
