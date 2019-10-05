class UpdateForeignKeyConstraints < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :books, :libraries
    add_foreign_key :books, :libraries, on_delete: :cascade
    remove_foreign_key :libraries, :users
    add_foreign_key :libraries, :users, on_delete: :cascade
  end
end
