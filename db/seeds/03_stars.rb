Gemm.find_each do |gem|
  gem.import_github
  puts gem.inspect
  sleep(1.seconds)
end