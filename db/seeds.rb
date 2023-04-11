# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
client_payload = []

(1..10).each do |i|
  client_payload << { email: "test#{i}@test.test", password: '123456', first_name: "Test#{i}", last_name: "Test#{i}", age: i * 10, auth_token: SecureRandom.uuid, bio: 'С 17 по 20 апреля приходи на неделю митапов для начинающих разработчиков от Яндекс. Будет доступен офлайн и онлайн формат.', position: 'SWE', avatar_url: 'https://www.gameinformer.com/s3/files/styles/body_default/s3/legacy-images/imagefeed/Update%3A%20Complete%20List%20Of%20Avatar%20Awards/avatarawardherree.jpg' }
end

Client.create!(client_payload)

Currency.create!(kind: 0)
Currency.create!(kind: 1)

products = [
  {
    title: 'Pepe Bag',
    price: 10,
    amount: 10,
    currency_id: 1,
    image_url: 'https://media.karousell.com/media/photos/products/2019/07/28/pepe_backpack_1564279245_c13eace1.jpg',
  },
  {
    title: 'Термос',
    price: 100,
    amount: 10,
    currency_id: 1,
    image_url: 'https://mytupperware.spb.ru/wp-content/uploads/2021/03/termos-vesna.jpg',
  },
  {
    title: 'Sandwich',
    price: 10,
    amount: 5,
    currency_id: 2,
    image_url: 'https://imagesvc.meredithcorp.io/v3/mm/image?q=60&c=sc&poi=face&url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2F1556744250%2Fthe-ultimate-veggie-sandwich-1905.jpg%3Fitok%3DrAOvFAhQ',
  }
]

Product.create!(products)

event_data = [
  {
    title: 'Поход в кино с командой',
    description: 'Фильм Аватар',
    deadline: 10.days.from_now,
    reward: 500,
    participants_needed: 20,
    experience: 500,
    currency_id: 1,
    category: 2,
  },
  {
    title: 'Курс по PHP',
    description: 'Laravel для самых маленьких',
    deadline: 10.days.from_now,
    reward: 250,
    participants_needed: 20,
    experience: 1500,
    currency_id: 1,
    category: 1,
  },
  {
    title: 'Курс по Ruby on Rails',
    description: 'Продвинутый Rails',
    deadline: 10.days.from_now,
    reward: 251,
    participants_needed: 20,
    experience: 1501,
    currency_id: 1,
    category: 1,
  },
]

Event.create!(event_data)


ratings = [
  {
    client_id: 1,
    score_change: 250,
  },
  {
    client_id: 2,
    score_change: 200,
  },
  {
    client_id: 3,
    score_change: 350,
  },
  {
    client_id: 4,
    score_change: 550,
  },
  {
    client_id: 5,
    score_change: 300,
  },
  {
    client_id: 6,
    score_change: 100,
  },
  {
    client_id: 7,
    score_change: 400,
  },
  {
    client_id: 8,
    score_change: 450,
  },
  {
    client_id: 9,
    score_change: 750,
  },
  {
    client_id: 10,
    score_change: 650,
  },
]

Rating.create!(ratings)

# create test data for forums
forum_titles = [
  'General Discussion',
  'Programming Help',
  'Music Fans',
  'Book Club',
  'Sports Enthusiasts'
]

user_ids = User.pluck(:id)
forum_ids = []

forum_titles.each do |title|
  forum_topic = Forum::Topic.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )

  forum = Forum.create!(
    title: title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    creator_id: user_ids.sample,
    topic: forum_topic
  )

  forum_ids << forum.id
end

# create test data for forum posts
forum_ids.each do |forum_id|
  10.times do
    Forum::Post.create!(
      creator_id: user_ids.sample,
      data: Faker::Lorem.paragraph(sentence_count: 3),
      forum_id: forum_id,
    )
  end
end

