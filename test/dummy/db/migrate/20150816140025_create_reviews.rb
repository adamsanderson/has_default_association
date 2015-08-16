class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :text
      t.integer :book_id
      t.integer :person_id

      t.timestamps null: false
    end
  end
end
