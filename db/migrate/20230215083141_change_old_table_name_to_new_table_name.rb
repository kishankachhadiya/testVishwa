class ChangeOldTableNameToNewTableName < ActiveRecord::Migration[6.1]
  def change
    rename_table :payment_historys, :payment_histories
  end

end
