Hanami::Model.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :users do
      primary_key :id, 'uuid', null: false, default: Hanami::Model::Sql.function(:uuid_generate_v4)

      # Auth
      column :provider, String, null: false, default: 'email'
      column :email, String, null: false
      column :encrypted_password, String, null: false
      column :admin, FalseClass, default: false

      ## Recoverable
      column :reset_password_token, String
      column :reset_password_sent_at, DateTime

      ## Trackable
      column :sign_in_count, Integer, null: false, default: 0
      column :current_sign_in_at, DateTime
      column :last_sign_in_at, DateTime
      column :current_sign_in_ip, String
      column :last_sign_in_ip, String

      ## Confirmable
      column :confirmation_token, String
      column :confirmed_at, DateTime
      column :confirmation_sent_at, DateTime
      column :unconfirmed_email, String

      # User info
      column :first_name, String, null: false
      column :last_name, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      # Index
      index :email, unique: true
      index :provider
    end
  end

  down do
    drop_table :users
    execute 'DROP EXTENSION IF EXISTS "uuid-ossp"'
  end
end
