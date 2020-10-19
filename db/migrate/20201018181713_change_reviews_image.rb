class ChangeReviewsImage < ActiveRecord::Migration[5.2]
  def change
    change_column_default :reviews, :image, "https://cdn.iconscout.com/icon/premium/png-256-thumb/pet-117-805569.png"
  end
end
