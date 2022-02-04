(0..rand(25..50)).each_with_index do |index|
  name = Faker::Name.name
  student = User.create!(
    email: "user-#{index+1}@gmail.com", 
    name: name, 
    username: name.parameterize,
    title: Faker::Hipster.sentence,
    description: Faker::Hipster.paragraph,
    password: "password", 
    password_confirmation: "password")
  puts student.inspect 
end  