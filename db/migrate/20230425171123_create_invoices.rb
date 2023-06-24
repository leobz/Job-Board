class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices, id: :uuid  do |t|
      t.belongs_to :job, index: true, foreign_key: true
      t.string :status
      t.decimal :amount
      t.decimal :fiat_value
      t.string :description
      t.string :currency
      t.string :customer_email
      t.string :notif_email
      t.string :callback_url
      t.string :success_url
      t.boolean :auto_settle
      t.integer :ttl


      t.timestamps
    end
  end
end
