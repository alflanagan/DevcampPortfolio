# frozen_string_literal: true

User.create(
  email: 'abc@example.com',
  password: '1234',
  password_confirmation: '1234',
  name: 'Admin User',
  roles: :site_admin
)

puts "1 Admin user created"

User.create(
  email: 'def@example.com',
  password: '5678',
  password_confirmation: '5678',
  name: 'Regular User'
)

puts "1 Admin user created"

count = 3.times do |topic|
  Topic.create!(
    title: "Topic #{topic}"
  )
end

puts "#{count} topics created"

count = 10.times do |blog|
  Blog.create!(
    title: "My Blog Post #{blog}",
    body: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem
    accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae
    ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt
    explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut
    odit aut fugit, sed quia consequuntur magni dolores eos qui ratione
    voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum
    quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam
    eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat
    voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam
    corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?
    Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam
    nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas
    nulla pariatur?',
    topic_id: Topic.last.id
  )
end

puts "#{count} blogs created"

count = 5.times do |skill|
  Skill.create!(
    title: "Rails #{skill}",
    percent_used: 15
  )
end

puts "#{count} skills created"

count = 8.times do |item|
  Portfolio.create!(
    title: "Portfolio Title #{item}",
    subtitle: 'Ruby on Rails',
    body: 'Et harum quidem rerum facilis est et expedita distinctio. Nam libero
    tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus
    id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis
    dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut
    rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae
    non recusandae.'
  )
end

count += 1.times do |item|
  Portfolio.create!(
    title: "Portfolio Title #{item}",
    subtitle: 'Angular',
    body: 'Et harum quidem rerum facilis est et expedita distinctio. Nam libero
    tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus
    id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis
    dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut
    rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae
    non recusandae.'
  )
end

puts "#{count} portfolio items created"

count = 3.times do |technology|
  Portfolio.last.technologies.create(
    name: "Technology #{technology}",
    portfolio_id: Portfolio.last.id
  )
end

puts "#{count} technologies created"
