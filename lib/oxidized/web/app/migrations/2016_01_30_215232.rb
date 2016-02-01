require 'sinatra'
migration 'Create Users Database' do
  database.create_table :users do
    primary_key :id
    text :first_name
    text :last_name
    text :client_id
    text :client_secret
    integer :privilege_level, null: false
    timestamp :created_at, null: false

    index :client_id, unique: true
  end
end
