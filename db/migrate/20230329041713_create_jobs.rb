class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.string :website
      # Note: In case of use the company table, use the following code:
      # t.belongs_to :company, index: true, foreign_key: true
      t.string :company
      t.binary :company_logo
      t.string :location
      t.integer :location_mode
      t.integer :salary
      t.integer :category

      t.timestamps
    end
  end
end
