class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.text :description
      t.string :status
      t.datetime :closed_at

      t.timestamps
    end
  end
end
