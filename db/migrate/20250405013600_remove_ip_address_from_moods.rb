class RemoveIpAddressFromMoods < ActiveRecord::Migration[8.0]
  def change
    remove_column :moods, :ip_address, :string
  end
end
