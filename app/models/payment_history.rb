class PaymentHistory < ApplicationRecord

  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User'
  belongs_to :job



end
