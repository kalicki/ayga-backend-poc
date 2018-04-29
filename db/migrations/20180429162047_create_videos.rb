Hanami::Model.migration do
  change do
    create_table :videos do
      primary_key :id

      # FK
      foreign_key :user_id, :users, on_delete: :cascade, null: false

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
end
