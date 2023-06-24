class CreateExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :experiences do |t|
      t.string :title
      t.string :company_name
      t.string :location
      t.boolean :currently_working
      t.date :star_date
      t.date :end_date
      t.integer :industry
      t.text :description
      t.timestamps
    end
  end
end
