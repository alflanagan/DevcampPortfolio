count = 10.times do |blog|
  Blog.create!(
    title: "My Blog Post #{blog}",
    body: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem
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
    nulla pariatur?"
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

count = 9.times do |item|
  Portfolio.create!(
    title: "Portfolio Title #{item}",
    subtitle: "My great service",
    body: "Et harum quidem rerum facilis est et expedita distinctio. Nam libero
    tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus
    id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis
    dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut
    rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae
    non recusandae.",
    main_image: "https://via.placeholder.com/600x400.png?text=Portfolio+Image",
    thumb_image: "https://via.placeholder.com/350x200.png?text=Portfolio+Thumbnail"
    )
end

puts "#{count} portfolio items created"
