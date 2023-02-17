class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :task_title
      t.integer :category_id, index: true
      t.string :payment_type
      t.string :subscription_name
      t.integer :price
      t.text :description
      t.text :job_description
      t.string :instrument
      t.string :influences
      t.string :equipment
      t.string :experience
      t.text :instruction_to_buyer
      t.datetime :availability
      t.datetime :from_availability_time
      t.datetime :to_availability_time
      t.string :location
      t.string :video_link
      t.string :tags
      t.integer :user_id , index: true
      t.timestamps
    end
  end
end
