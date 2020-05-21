Note.delete_all
Task.delete_all
Planner.delete_all
User.delete_all

User.create(username: "lee", email:"poo@gmail.com", password:"poo")
Planner.create(user_id: 1)
Task.create(
    name: "do dishes",
    planner_id: 1,
    status: "active",
    is_completed: false,
    date: "20200101"
)
Task.create(
    name: "mow the lawn",
    planner_id: 1,
    status: "active",
    is_completed: false,
    date: "20200101"
)
Task.create(
    name: "go poop",
    planner_id: 1,
    status: "active",
    is_completed: false,
    date: "20200102"
)