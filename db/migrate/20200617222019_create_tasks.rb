class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false
      t.string :card_title, null: false
      t.text :card_content, null: false
      t.date :deadline, null: false
      t.timestamps
    end
  end
end
