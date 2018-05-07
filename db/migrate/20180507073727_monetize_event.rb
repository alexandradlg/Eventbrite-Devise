class MonetizeEvent < ActiveRecord::Migration[5.2]
  def change
    add_monetize :events, :price
  end
end
