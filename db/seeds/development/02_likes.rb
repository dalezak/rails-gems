count = Gemm.count
Gemm.find_each do |gem|
  limit = rand(10..count)
  User.all.sample(limit).each do |user|
    like = Like.create(gem: gem, user: user)
    puts like.inspect
  end
end