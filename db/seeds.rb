u1 = User.create(email: 'one@example.com', password: 'password', name: "User1")
u2 = User.create(email: 'two@example.com', password: 'password', name: "User2")

p1 = Project.create(title: 'project1',
                    description: 'my first project',
                    full_description: 'here is a full description placeholder',
                    goal: 500,
                    end_date: DateTime.new(2020, 8, 31, 11, 0, 0),
                    owner_id: 1,
                    category_id: 1)

p2 = Project.create(title: 'project2',
                    description: 'my second project',
                    full_description: 'here is a full description placeholder',
                    goal: 1000,
                    end_date: DateTime.new(2030, 4, 27, 11, 0, 0),
                    owner_id: 1,
                    category_id: 1)

p1 = Project.create(title: 'projectApple',
                    description: '2s first project',
                    full_description: 'here is a full description placeholder',
                    full_description: 'here is a full description placeholder',
                    goal: 500,
                    end_date: DateTime.new(2015, 10, 31, 11, 0, 0),
                    owner_id: 2,
                    category_id: 1)
c1 = Category.create(title: 'category1')
r1 = Reward.create(project_id: 1,
                    pledge_amount: 5,
                    description: "a high five for every five",
                    limited_quantity: 150,
                    estimated_delivery: Date.new(2020, 11),
                    shipping_location: "Only United States")
r2 = Reward.create(project_id: 1,
                    pledge_amount: 15,
                    description: "bobblehead of your favorite character",
                    estimated_delivery: Date.new(2020, 12),
                    shipping_location: "Anywhere in the world")
r3 = Reward.create(project_id: 1,
                    pledge_amount: 100,
                    description: "a no questions asked",
                    estimated_delivery: Date.new(2020, 11))
