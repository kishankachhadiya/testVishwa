class CreatePaymentHistorys < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_historys do |t|
      t.string 'job_id'
      t.string 'price'
      t.string 'user_id'
      t.string 'customer_id'
      t.string  'source_id'
      t.string 'charge_id'
      t.string 'token_id'
      t.string 'email'
      t.timestamps
    end
  end
end
