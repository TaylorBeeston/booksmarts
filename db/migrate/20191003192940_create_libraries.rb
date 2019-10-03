class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    change_table :books do |t|
      t.remove_references :user
      t.references :library, null: false, foreign_key: true
    end
  end
end
