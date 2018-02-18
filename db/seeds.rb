require 'faker'

user = User.create(email: 'ianflorentino88@gmail.com', first_name: 'Ian', last_name: 'Florentino', password: 'password')

20.times do
  first_name = Faker::Name.first_name
  friend = User.create(
    email: Faker::Internet.email(first_name), 
    first_name: first_name, 
    last_name: Faker::Name.last_name, 
    password: 'password')
  user.friends << friend
  user.save
end

3.times do
  event = Event.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    location: Faker::Address.full_address,
    start_date: Faker::Date.forward(7),
    end_date: Faker::Date.forward(9))

  event.users << user
  
  10.times do
    rand_user = User.where.not(id: 1).sample(1).first
    comment = event.comments.create(body: Faker::MostInterestingManInTheWorld.quote, user: rand_user)
    2.times do
      rep_user = User.where.not(id: 1).sample(1).first
      comment.replies << Comment.new(body: Faker::MostInterestingManInTheWorld.quote, user: rep_user)
    end
  end
end
