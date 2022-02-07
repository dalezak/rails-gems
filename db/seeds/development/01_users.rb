(0..rand(25..50)).each_with_index do |index|
  name = Faker::Name.name
  student = User.create!(
    email: "user-#{index+1}@gmail.com",
    slug: name.parameterize,
    name: name,
    title: Faker::Hipster.sentence,
    description: Faker::Hipster.paragraph,
    image_remote_url: "https://randomuser.me/api/portraits/#{['men','women'].sample}/#{index}.jpg",
    password: "password", 
    password_confirmation: "password")
  puts student.inspect 
end  