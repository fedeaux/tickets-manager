class CreateTicketMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_messages do |t|
      t.belongs_to :ticket, foreign_key: true
      t.belongs_to :user
      t.text :text
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
