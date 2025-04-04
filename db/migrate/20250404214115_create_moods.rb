class CreateMoods < ActiveRecord::Migration[8.0]
  def change
    create_table :moods do |t|
      t.column :emotion, "ENUM('not_good_at_all', 'a_bit_meh', 'pretty_good', 'felling_greate')", null: false, default: 'pretty_good'
      t.integer :rating
      t.text :comment
      t.string :ip_address

      t.timestamps
    end
  end
end
