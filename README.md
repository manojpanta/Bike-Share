# Bike Share

*Bike-Share* is the final project for Back-End Engineering Module 2 at Turing School of Software and Design. This was a team project with three contributors. The purpose of the project was to gain familiarity with one-to-many and many-to-many relationships within Rails and build a project from scratch with only user stories, no wireframes.  Features of the project include simple analysis of SF Bay Area Bike Share data from kaggle.com.

The app also has an e-commerce area where visitors can add accessories to their cart, and registered users can checkout their cart to create an order. The app features a secure login for users and admins, with users, accessories, orders, accessory_orders, stations, and trips in a PostgreSQL database.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

This project uses these gems:
--include versions
 * figaro
 * bcrypt
 * rspec
 * capybara
 * launchy
 * should-matchers
 * pry
 * active_designer
 * simplecov

### Prerequisites
--Ruby versions
--postgres -v
Standard Rails setup for *Rails 5.2*

### Installing

To install dependencies after cloning the app, run in the command line:
`bundle install`

To setup the database, run:
`rails db:create`
`rails db:migrate`
`rails db:seed`

To run the server on localhost:3000, run:
`rails s`


## Running the tests

Run `rspec` in the terminal.

## Using The Site

--bullet points for visitors, users, admins

Visitors can view stations index and show, trips index and show, accessories index and show, and they are able to login, create a new account, or add items to a cart before logging in. Logged in users can view and edit their profile, checkout their cart, and view additional analytics data. Admin users can be created from the command line. They can create, edit, and delete stations, trips, and accessories.


--see this projects at heroku

## Authors

* **Manoj Panta** -   (https://github.com/manojpanta)
* **Steve Schwedt** - (https://github.com/apoc64)
* **Eliot Swank** -   (https://github.com/EMSwank)
