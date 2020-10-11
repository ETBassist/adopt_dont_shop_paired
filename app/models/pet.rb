class Pet < ApplicationRecord
  belongs_to :shelter

  def status
    if adoptable?
      "Adoptable"
    else
      "Pending Adoption"
    end
  end

end
