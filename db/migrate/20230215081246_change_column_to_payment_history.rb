class ChangeColumnToPaymentHistory < ActiveRecord::Migration[6.1]
  def change
    change_column :payment_histories, :job_id, 'integer USING CAST(job_id AS integer)'
    change_column :payment_histories, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
