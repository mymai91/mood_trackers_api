# Mood Trackers API

This is the API application for Mood Trackers application.

## Getting Started

- Ensure the ruby version is 3.2.2

- Create the `.env` file with following content:

```
DB_USERNAME=root
DB_PASSWORD=password
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=mood_trackers_development
RAILS_MAX_THREADS=5
RAILS_MASTER_KEY=956e6c59a367ebf4ef832a2ba2217a90
```

- Start the database server using docker compose

```
docker compose up
```

- Open a new terminal, run following commands:

  - Install dependencies: `bundle install`

  - Create databases for test & development environment: `bin/rails db:create`

  - Run migration: `bin/rails db:migrate`

  - Run seed: `bin/rails db:seed`

  - Run unit tests: `bin/rails spec`

  - Run the server: `bin/rails server`. The server availables at port 3000

- Access the admin: `http://localhost:3000/admin`

- Import the API documentation to Postman, and try APIs.
