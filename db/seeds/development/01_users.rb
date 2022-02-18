(1..rand(25..50)).each_with_index do |index|
  name = Faker::Name.name
  user = User.create!(
    email: "user-#{index}@gmail.com",
    slug: name.parameterize,
    name: name,
    title: Faker::Hipster.sentence,
    location: Faker::Address.city,
    description: Faker::Hipster.paragraph,
    homepage_uri: Faker::Internet.url,
    twitter_uri: "https://twitter.com/#{name.parameterize}",
    password: "password", 
    password_confirmation: "password")
  puts user.inspect
  begin
    user.image_remote_url = "https://randomuser.me/api/portraits/#{['men','women'].sample}/#{index}.jpg"
    user.save
  rescue => exception
    puts exception  
  end
end  