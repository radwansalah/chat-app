class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.bigint :chat_num, null: false
      t.references :application, foreign_key: true, type: :string, null: false
      t.integer :messages_count, null: false, default: 0
      t.boolean :is_deleted, null: false, default: false

      t.timestamps

      t.index [:chat_num, :application_id], unique: true
    end
  end
end
