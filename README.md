# URL Shortener

A Simple URL shortener application built using Ruby On Rails which can shorten a long url to a fixed length short link which can be used to share where each character count matters such as SMS, Tweets, etc.

# Requirements

* Ruby version 2.7+

* [Bundler](https://bundler.io/)

* [PostgreSQL 10](https://www.postgresql.org/download/)

# Running the application locally

Run the following commands in terminal after installing requirements in your development machine.

* Clone the repository
```
$ git clone git@github.com:anshabmk/url-shortener.git

```
* Install dependencies
```
$ bundle install
```

* Setup Database
```
$ bundle exec rails db:setup
```

* Serve the application
```
$ rails s
```
The application should be running on (http://localhost:3000)

# Running the test suite

```
bundle exec rspec
```

# Notes on scalability

* ### Exhausting available unique tokens

  By default, the application generates a unique token of length 5(configurable). This may lead to exhaustion of all available combinations of tokens on long run. 

  We can accomodate url-safe characters other than alphanumeric which is the default now for increasing our number of available combinations.

  Also, we can reconsider the tokens which are expired.
