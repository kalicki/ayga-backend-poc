Hanami::Model.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :videos do
      primary_key :id, 'uuid', null: false, default: Hanami::Model::Sql.function(:uuid_generate_v4)

      # FK
      foreign_key :user_id, :users, type: 'uuid', on_delete: :cascade, null: false

      # Infos
      column :title, String, null: false
      column :description, String, null: false
      column :thumbnail, String, null: false
      column :url_video, String, null: false
      column :tags, 'text[]'
      column :visible, TrueClass, null: false, default: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      # Index
      index :title
      index :tags
    end
  end

  down do
    drop_table :videos
    execute 'DROP EXTENSION IF EXISTS "uuid-ossp"'
  end
end
