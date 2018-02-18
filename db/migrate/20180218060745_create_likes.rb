class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, index: true
      t.references :content, polymorphic: true

      t.timestamps
    end
  end
end
