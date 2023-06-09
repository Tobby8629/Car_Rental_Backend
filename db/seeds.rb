# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create Users
admin = User.create(username: "Uche")

# Create Cars
car1 = Car.create(
  name: "Ford",
  model: "M5",
  description: "A luxury sedan with impressive performance.",
  price: 250.5,
  user: admin,
  photo: 'https://images.cars.com/cldstatic/wp-content/uploads/ford-f-150_lightning-lariat-exterior-front-angle-oem-scaled.jpg'
)

car2 = Car.create(
  name: "Tesla",
  model: "Model 3",
  description: "An electric car with cutting-edge technology.",
  price: 300.9,
  user: admin,
  photo: 'https://images.cars.com/cldstatic/wp-content/uploads/3185-GENESISREVEALS2023G90U.S.PRICING.jpg'
)



