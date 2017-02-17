namespace :utils do
  desc "Criar administradores fake"
  task generate_admins: :environment do
    puts "Criando administradores fakers"
    10.times do
        Admin.create!(name:Faker::Name.name,
                     email: Faker::Internet.email,
                     password:"123456",
                     password_confirmation:"123456",
                     role: [0,0,1,1,1].sample)
    end
    puts "administradores fakers criados com sucesso!!"
  end
  #########################################################################
    desc "Criar members fake"
    task generate_members: :environment do
      puts "Criando members fakers"
      100.times do
          Member.create!(email: Faker::Internet.email,
                         password:"123456",
                         password_confirmation:"123456"
                       )
      end
      puts "Member fakers criados com sucesso!!"
    end
  #########################################################################
  desc "Cria Anúncios Fake"
    task generate_ads: :environment do
      puts "Cadastrando ANÚNCIOS..."

      100.times do
        Ad.create!(
          title: Faker::Lorem.sentence([2,3,4,5].sample),
          description: LeroleroGenerator.paragraph(Random.rand(3)),
          #description_short: Faker::Lorem.sentence([2,3].sample),
          member: Member.first,
          category: Category.all.sample,
          price: "#{Random.rand(500)},#{Random.rand(99)}",
          #finish_date: Date.today + Random.rand(90),
          picture:File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
        )
      end

     #  100.times do
     #   Ad.create!(
     #     title: Faker::Lorem.sentence([2,3,4,5].sample),
     #     description_md: markdown_fake,
     #     description_short: Faker::Lorem.sentence([2,3].sample),
     #     member: Member.all.sample,
     #     category: Category.all.sample,
     #     price: "#{Random.rand(500)},#{Random.rand(99)}",
     #     finish_date: Date.today + Random.rand(90),
     #     picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
     #   )
     # end

      puts "ANÚNCIOS cadastrados com sucesso!"
  end
end
