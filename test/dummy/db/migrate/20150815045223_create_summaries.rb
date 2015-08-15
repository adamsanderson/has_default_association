class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.string :text
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
