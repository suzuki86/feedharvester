class Initialize < ActiveRecord::Migration[5.0]
  def change
    create_table :entrypoints do |t|
      t.string :name
      t.string :entrypoint
      t.timestamps
    end

    create_table :feeds do |t|
      t.belongs_to :entrypoint
      t.string :url
      t.string :title
      t.datetime :entry_created, null: false
      t.timestamps
    end
  end
end
