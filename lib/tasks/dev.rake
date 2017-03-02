namespace :dev do

  desc "setup development"
  task setup: :environment do
   images_path = Rails.root.join('public','system')
   puts "Executar setup para desenvolvimento"

   puts "Apagando banco de dados #{%x(rake db:drop)}"
   puts "Apagando images de public #{%x(rm -rf #{images_path})}"
   puts "Criando banco de dados #{%x(rake db:create)}"
   puts %x(rake db:migrate)
   puts %x(rake db:seed)
   puts %x(rake dev:generate_admins)
   puts %x(rake dev:generate_members)
   puts %x(rake dev:generate_ads)

    puts "Fim da execusao do setup de desenvolvimento"
  end

  #########################################################################
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
          description: markdown_faker, #LeroleroGenerator.paragraph(Random.rand(1..3)),
          #description_short: Faker::Lorem.sentence([2,3].sample),
          member: Member.all.sample,
          category: Category.all.sample,
          price: "#{Random.rand(500)},#{Random.rand(99)}",
          finish_date: Date.today + Random.rand(90),
          picture:File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
        )
      end

      5.times do
        Ad.create!(
          title: Faker::Lorem.sentence([2,3,4,5].sample),
          description: markdown_faker,  #LeroleroGenerator.paragraph(Random.rand(1..3)),
          #description_short: Faker::Lorem.sentence([2,3].sample),
          member: Member.first,
          category: Category.all.sample,
          price: "#{Random.rand(500)},#{Random.rand(99)}",
          finish_date: Date.today + Random.rand(90),
          picture:File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
        )
      end

      puts "ANÚNCIOS cadastrados com sucesso!"
  end

  def markdown_faker
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end
end
