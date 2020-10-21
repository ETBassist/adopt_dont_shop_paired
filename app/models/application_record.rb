class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.sorted_by(param)
    if param == 'adoptable'
      joins(:pets).where('pets.adoptable = true').group(:id).order(Arel.sql('count(pets.adoptable) desc'))
    elsif param == 'alphabetical'
      order(:name)
    elsif param == 'highest'
      order(rating: :desc, created_at: :desc)
    elsif param == 'lowest'
      order(:rating, :created_at)
    else
      all
    end
  end
end
