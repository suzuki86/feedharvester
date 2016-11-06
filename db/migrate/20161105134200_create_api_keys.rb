class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.belongs_to :user
      t.string :access_token
      t.boolean :active
      t.timestamps
    end

    add_index :api_keys, ["access_token"], name: "index_api_keys_on_access_token", unique: true
  end
end
