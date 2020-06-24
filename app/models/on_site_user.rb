class OnSiteUser < ApplicationRecord
  belongs_to :auction

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :number, presence: true
  validates :number, uniqueness: true
end
