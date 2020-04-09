class Favourite < ApplicationRecord
  belongs_to :favouritable, polymorphic: true
  belongs_to :user
end
