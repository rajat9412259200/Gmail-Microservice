class CreateMailSearchings < ActiveRecord::Migration[5.1]
  def change
    create_table :mail_searchings do |t|
      t.string :uid
      t.string :field
      t.jsonb :thread_id
      t.string :text
      t.jsonb  :data
      t.timestamps
    end
  end
end
