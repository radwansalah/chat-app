class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages, primary_key: [:id, :chat_id] do |t|
      t.bigint :id, null: false
      t.references :chat, foreign_key: true
      t.text :body, null: false
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end
  end
end
