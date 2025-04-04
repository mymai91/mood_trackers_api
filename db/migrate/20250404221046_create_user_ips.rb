class CreateUserIps < ActiveRecord::Migration[8.0]
  def change
    create_table :user_ips do |t|
      t.string :ip_address

      t.timestamps
    end

    add_index :user_ips, :ip_address, unique: true
  end
end
