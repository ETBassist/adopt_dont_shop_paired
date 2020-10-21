# Adopt Don't Shop

<img src="https://placedog.net/280?random" alt="Dog"/>

## Table of Contents
  * [Description](#description)
  * [Contributors](#contributors)
  * [Technology](#technology)
  * [Demo Website](#demo-website)
  * [Running Locally](#running-locally)
  * [Database Schema](#database-schema)
  * [Learning Goals](#learning-goals)

## Description

"Adopt Don't Shop Paired" is a fictitious pet adoption platform where visitors can leave reviews and apply to adopt their newest furry friend.

## Contributors

  * [Eugene Theriault](https://github.com/ETBassist)
  * [Kate Tester](https://github.com/katemorris)
  * [Eduardo Parra](https://github.com/helloeduardo)

## Technology

This application runs on Ruby 2.5.3 and Rails 5.2.4 and utilizes a PostgreSQL database. Deployment is via Heroku.

## [Demo Website](https://thawing-reef-51053.herokuapp.com)

## Running Locally

You may `fork` and/or `clone` this repository locally. Then, from the project root directory, run:

```
bundle install
rails db:create
rails db:migrate
rails db:seed
```

After successful database creation, you may now start a rails server:

```
rails s
```

Now, navigate to `http://localhost:3000/` on your browser to view the application!

## Database Schema
![Database Schema](https://user-images.githubusercontent.com/56360157/96794220-0c3bf480-13bb-11eb-90e5-0875f2aa7c75.png)

## Learning Goals  

[Turing School Adopt Don't Shop Paired Project](https://github.com/turingschool-examples/adopt_dont_shop_paired)

### Rails

* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Make use of flash messages


* Use Inheritance from ApplicationController or a student created controller to store methods that will be used in multiple controllers

### ActiveRecord
* Use built-in ActiveRecord methods to:
  * create queries that calculate, select, filter, and order data from a single table

### Databases
* Describe Database Relationships, including the following terms:
  * Many to Many
  * Join Table

### Testing and Debugging
* Write feature tests utilizing
* Sad Path Testing
* Write model tests with RSpec including validations, and class and instance methods

### Web Applications
* Describe and implement ReSTful routing
* Identify use cases for, and implement non-ReSTful routes
* Identify the different components of URLs(protocol, domain, path, query params)
