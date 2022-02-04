User.find_each do |user|
  Gemm.order(Arel.sql('RANDOM()')).limit(rand(25..50)).find_each do |gem|
    like = gem.likes.create(user: user)
    puts like.inspect
  end  
end