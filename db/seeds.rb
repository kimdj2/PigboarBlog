# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
metal, jazz = Category.create([{category_name: "metal"}, {category_name: "jazz"}])
melodic, black = metal.children.create([{category_name: "melodic"}, {category_name: "black"}])
melodic.children.create([{category_name: "melodic-death"}, {category_name: "melodic-speed"}])
black.children.create([{category_name: "symphonic-black"}, {category_name: "melodic-black"}])
swing, modern = jazz.children.create([{category_name: "swing"}, {category_name: "modern"}])