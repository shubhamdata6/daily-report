# Daily Report

A simple Rails application which captures user data from https://randomuser.me/api/?results=20, store and manage users. Also use redis and sidekiq to set male and female count and create a daily record using the redis values. Used Sidekiq to perform jobs for user operations and daily records. This application uses Bootstrap for styling and Kaminari for pagination.

## Dependencies

### Ruby and Rails

- Ruby: `3.1.2`
- Rails: `7.0.1`

### Gems
- **Kaminari**: For pagination.
- **Redis** to store data
- **Rspec** for unit test cases
- **Rubocop** for code enhancement and conventions

## Getting Started

Follow below instructions to run the project on your machine.

### Prerequisites

Ensure you have the following installed:

- Ruby
- Rails
- Bundler
- Redis
- Sidekiq
- Postgresql

### Installation

1. **Clone the repository**:

    ```sh
    git clone https://github.com/shubhamdata6/daily-report.git
    cd daily-report
    ```

2. **Install dependencies**:

    ```sh
    bundle install
    ```

3. **Set up the database**:
  - Set database username and password in 'credentials.yml.enc':
    run `EDITOR='code --wait' bin/rails credentials:edit` on console to edit 'credentials.yml.enc'

    ```sh
    rails db:create
    rails db:migrate
    ```

4. **Start the Rails server**:

    ```sh
    rails server
    ```

5. **Visit the application**:

    Open your browser and go to `http://localhost:3000`.

## Usage

### Search Users

- Use the search bar at the top of the users index page to search for users by name.

### Delete Users

- Click the "Delete" button next to a user to remove them from the database. This will also update the daily record.

### View Daily Records

- Click the "View Daily Record Report" button to view the daily records report, which shows the average count and age of male and female users.

## Project Structure

### Controllers

- `UsersController`: Handles user listing, searching, and deletion.
- `DailyRecordsController`: Handles displaying the daily records report.

### Models

- `User`: Represents a user with attributes like `name`, `age`, `gender`, and `created_at`.
- `DailyRecord`: Represents daily records with attributes like `date`, `male_count`, `female_count`, `male_avg_age`, and `female_avg_age`.

## Services
- `UserOperationsService`
- `DailyRecordService`

## Jobs
- `CaptureUsersJob`
- `DailyRecordJob`

### Views

- `users/index.html.erb`: Displays the list of users with search and delete functionality.
- `daily_records/index.html.erb`: Displays the daily records report.

## Adding Pagination with Kaminari

We use Kaminari to paginate the list of users and daily records.



## Note:
- Applied rubocop to maintain coding conventions
- To run scheduled cron jobs these needs to be installed and running.

- Redis server
- Sidekiq
