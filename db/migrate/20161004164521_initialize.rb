class Initialize < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :title
      t.datetime :entry_created, null: false
      t.timestamps
    end
  end
end
