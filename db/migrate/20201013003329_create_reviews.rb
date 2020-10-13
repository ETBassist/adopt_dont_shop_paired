class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :image
      t.references :user, foreign_key: true
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
