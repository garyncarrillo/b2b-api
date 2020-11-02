namespace :update_uui_user do
  desc "TODO"

  task uui: :environment do
    users = User.all

    users.each do |user|
      user.update(uuid: SecureRandom.uuid)
    end
  end

end
