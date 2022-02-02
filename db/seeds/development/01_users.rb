(0..rand(25..50)).each_with_index do |index|
  name = Faker::Name.name
  password = Devise.friendly_token
  student = User.create!(
    email: Faker::Internet.email, 
    name: name, 
    username: name.parameterize,
    title: Faker::Hipster.sentence,
    description: Faker::Hipster.paragraph,
    password: password, 
    password_confirmation: password)
  puts student.inspect 
end  