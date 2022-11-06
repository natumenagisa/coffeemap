class AddAddressToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :address, :string
  end
end
