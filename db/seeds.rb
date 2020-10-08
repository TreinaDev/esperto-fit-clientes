p 'seeding'

10.times do |i|
  Client.create!(
    email: "test#{i}@email.com",
    password: 'password',
    cpf: CPF.generate(formatted: true)
  )
end

p 'done!'
