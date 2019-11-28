class RemoveWayFromDeliveries < ActiveRecord::Migration[5.0]
  def change
    remove_column :deliveries, :way, :string
  end
end
