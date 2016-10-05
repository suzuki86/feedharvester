class Initialize < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :title
      t.timestamp
    end
  end
end
