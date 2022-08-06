class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.bigint :message_num, null: false
      t.references :chat, foreign_key: true
      t.text :body, null: false
      t.boolean :is_deleted, null: false, default: false

      t.timestamps

      t.index [:message_num, :chat_id], unique: true
    end
  end
end
