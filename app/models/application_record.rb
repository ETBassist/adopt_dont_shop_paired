class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.sorted_by(param)
    if param == "adoptable"
      # TODO: Refactor with ActiveRecord
      # Shelter.joins(:pets).group(:id).order(pets.count(:adoptable))
      self.all.sort_by do |shelter|
        shelter.pets.count(:adoptable)
      end.reverse
    elsif param == "alphabetical"
      order(:name)
    elsif param == "highest"
      order(rating: :desc, created_at: :desc)
    elsif param == "lowest"
      order(:rating, :created_at)
    else
      self.all
    end
  end
end
