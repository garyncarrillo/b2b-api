class CustomerSerializer < BaseSerializer
  attributes :id, :email, :first_name, :last_name, :company, :phone, :role
end
