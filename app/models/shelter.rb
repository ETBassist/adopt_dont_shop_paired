class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy

  def self.sorted_by(param)
    if param == "adoptable"
      Shelter.all.sort_by do |shelter|
        shelter.pets.count(&:adoptable)
      end.reverse
    elsif param == "alphabetical"
      Shelter.all.sort_by(&:name)
    else
      Shelter.all
    end
  end
end
