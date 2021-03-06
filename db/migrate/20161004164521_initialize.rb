class Initialize < ActiveRecord::Migration[5.0]
  def change
    create_table :endpoints do |t|
      t.string :name
      t.string :endpoint
      t.datetime :last_fetched
      t.timestamps
    end

    create_table :feeds do |t|
      t.belongs_to :endpoint
      t.string :url
      t.string :title
      t.datetime :entry_created, null: false
      t.timestamps
    end

    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.timestamps
    end

    add_index :users, ["email"], name: "index_unique_email", unique: true
  end
end
