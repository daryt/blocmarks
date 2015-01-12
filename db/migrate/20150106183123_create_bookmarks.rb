class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.string :url
      t.string :topics
      t.references :user, index: true

      t.timestamps
    end
  end
end
