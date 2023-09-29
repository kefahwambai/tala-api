class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.integer :amount
      t.integer :interest_rate
      t.integer :interest_amount
      t.date :start_date
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
