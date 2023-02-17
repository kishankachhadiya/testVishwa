class AddColSellerIdToPaymentHistory < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_histories, :seller_id,:integer
  end
end
