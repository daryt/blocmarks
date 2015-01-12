class RemoveTopicsFromBookmarks < ActiveRecord::Migration
  def change
    remove_column :bookmarks, :topics, :string
  end
end
