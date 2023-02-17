class Job < ApplicationRecord

  resourcify

  validates :price , presence:true

  has_many :payment_histories
  belongs_to :category
  belongs_to :user
  has_many_attached :images
  has_one_attached :image


end
