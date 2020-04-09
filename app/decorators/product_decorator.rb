class ProductDecorator < ApplicationDecorator
  def is_favourite?
    object.favourites.find_by(user: self.context[:user]).present?
  end
end
