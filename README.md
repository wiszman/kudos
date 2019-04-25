To Run:

1. Create database `kudos_development` with username `kudos` and no password

2. Generate random data

`# rake db:repopulate`

3. Start app

`# rails s`

4. Navigate to `localhost:3000`

5. Select any email address from users table to login, password = `password`


Notes:

Kudos for the week are calculated based on midnight Sunday morning as the start of a given week.


This application requires:

- Ruby 2.5.1
- Rails 5.2.3
