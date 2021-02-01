class CustomerSerializer < BaseSerializer
  attributes :id, :email, :first_name, :last_name, :company, :phone, :role, :active, :nick_name
end
