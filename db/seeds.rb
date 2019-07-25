# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
user = User.create(first_name: 'Admin', last_name: "Example", email: "admin@example.com", password: "password")

user.save(validate: false)

user.add_role "admin"