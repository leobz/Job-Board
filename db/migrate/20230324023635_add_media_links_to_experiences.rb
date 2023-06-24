class AddMediaLinksToExperiences < ActiveRecord::Migration[7.0]
  def change
    add_column :experiences, :media_links, :string, array: true, default: []
  end
end
