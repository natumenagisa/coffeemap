class RemoveAddressFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :Address, :string
  end
end
