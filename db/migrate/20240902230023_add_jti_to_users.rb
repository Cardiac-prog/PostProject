class AddJtiToUsers < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:users, :jti)
      add_column :users, :jti, :string, null: false
      add_index :users, :jti, unique: true
    end
  end
end
