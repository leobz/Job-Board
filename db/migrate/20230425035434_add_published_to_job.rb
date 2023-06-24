class AddPublishedToJob < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :published, :boolean, default: false
  end
end
