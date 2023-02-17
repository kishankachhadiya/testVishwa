class RanameUserIdToBuyerId < ActiveRecord::Migration[6.1]
  def change
    rename_column :payment_histories ,"user_id" , "buyer_id"
  end
end
