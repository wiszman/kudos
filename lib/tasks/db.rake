namespace :db do
  desc "TODO"
  task repopulate: [:drop, :create, :migrate, :fakeit] do
    puts "Done"
  end

  desc "Generate fake data"
  task fakeit: :environment do
    num_companies = 100
    min_num_users_per_company = 10
    max_num_users_per_company = 50
    num_kudos_per_company = 50

    company_users = {}
    org_id = 1
    num_companies.times do
      Organization.create!(
        name: Faker::Company.name
      )
      # Number of users per company varies between min/max
      num_users = rand(min_num_users_per_company..max_num_users_per_company)
      company_users[org_id] = num_users
      num_users.times do
        name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
        User.create!(
          name: name,
          email: Faker::Internet.email(name),
          password: 'password',
          organization_id: org_id
        )
      end
      org_id += 1
    end

    org_id = 1
    num_companies.times do
      # Assign each company an average of 3 kudos/person
      num_kudos = company_users[org_id] * 3
      num_kudos.times do
        # Only allow kudos between 2 different users in same org
        user_id_list = User.where(organization: org_id).map(&:id)
        given_by = user_id_list[rand(0..user_id_list.length-1)]
        user_id_list.delete(given_by)
        given_to = user_id_list[rand(0..user_id_list.length-1)]
        Kudo.create!(
          given_by: User.find(given_by),
          given_to: User.find(given_to),
          message: Faker::Lorem.sentence
        )
      end
      org_id += 1
    end
  end

end
