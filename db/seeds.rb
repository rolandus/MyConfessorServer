# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(firstName: "Roland", 
            lastName: "Scott", 
            homePhone: "6084370956", 
            mobilePhone: "6083456857",
            email: "roland.scott@gmail.com",
            streetAddress: "303 North 3rd Street",
            city: "Mount Horeb",
            state: "Wisconsin",
            country: "United States of America",
            diocese: "Madison",
            parish: "Saint Mary of Pine Bluff",
            password: "asdf" )
