class CreateEducations < ActiveRecord::Migration[7.0]
  def change
    create_table :educations do |t|
      t.string :school
      t.string :degree
      t.integer :discipline
      t.date :star_date
      t.date :end_date

      t.timestamps
    end
  end
end
