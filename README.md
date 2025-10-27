# Campaign Task Manager API – Debugging & Development Challenge (Submission)

This repository contains my completed submission for the **Goat Developer Challenge**.
It includes all fixes for the Campaign bugs, the full implementation of the Task model, and the bonus user relationships.

---

## Overview

The project implements a fully functional REST API for managing **Campaigns** and **Tasks**, following a `/api/v1/` namespace.
Each Task is associated with a Campaign and optionally linked to Users as `created_by` and `assigned_to`.

The challenge focused on:

1. Fixing **9 existing bugs** in Campaign functionality
2. Building the **Task model and controller** from scratch
3. Implementing **nested routes** under Campaigns
4. Adding **user relationships** for bonus points
5. Ensuring **RSpec tests pass** and API outputs expected JSON

---

## Setup Instructions

```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
```

Runs locally on `http://localhost:3000`.

### Running Tests

```bash
bundle exec rspec
```

---

## Current Status

### ✅ Fixed / Implemented

* Campaign model + controller fully functional
* All 9 Campaign bugs resolved
* Task model + migrations created
* Task controller + routes implemented
* Nested routes for `/api/v1/campaigns/:campaign_id/tasks`
* Added filtering (`status`, `priority`)
* Added user relationships (`created_by`, `assigned_to`)
* CORS configured for local Vite frontend
* All RSpec tests passing

---

## Approach

### Phase 1 – Campaign Fixes

* Rebuilt model validations (`name`, `status`)
* Corrected enum and association syntax
* Completed missing strong parameters
* Updated controller actions to render consistent JSON structures
* Fixed filtering logic in index endpoint (use `where` instead of `find_by`)

### Phase 2 – Task Model & Routes

* Created model with `status` and `priority` enums
* Validation for `title`
* Added `belongs_to :campaign`
* Implemented nested routes for tasks under campaigns
* Added independent routes for `/api/v1/tasks/:id` for show, update, delete

### Phase 3 – Bonus: User Relationships

* Added foreign keys `created_by_id` and `assigned_to_id` to tasks
* Implemented model associations:

  ```ruby
  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :assigned_to, class_name: 'User', optional: true
  ```
* Task responses include user data (Almost forgot this one 😬)

---

## Example Endpoints

| Method | Endpoint                               | Description                      |
| ------ | -------------------------------------- | -------------------------------- |
| GET    | `/api/v1/campaigns`                    | List campaigns with `task_count` |
| GET    | `/api/v1/campaigns/:id`                | Show campaign and related tasks  |
| POST   | `/api/v1/campaigns`                    | Create campaign                  |
| PATCH  | `/api/v1/campaigns/:id`                | Update campaign                  |
| DELETE | `/api/v1/campaigns/:id`                | Delete campaign and tasks        |
| GET    | `/api/v1/campaigns/:campaign_id/tasks` | List tasks for campaign          |
| POST   | `/api/v1/campaigns/:campaign_id/tasks` | Create task                      |
| GET    | `/api/v1/tasks/:id`                    | Show task                        |
| PATCH  | `/api/v1/tasks/:id`                    | Update task                      |
| DELETE | `/api/v1/tasks/:id`                    | Delete task                      |

---

## Challenges & Solutions

| Challenge                             | Solution                                                                  |
| ------------------------------------- | ------------------------------------------------------------------------- |
| Missing `task_count` in Campaign list | Used `includes(:tasks)` and `.map` to merge counts                        |
| `find_by` returning one record        | Changed to `.where` for proper filtering                                  |
| CORS errors with frontend             | Allowed `origins 'http://localhost:3000', 'http://localhost:3001'`        |
| JSON shape mismatch in tests          | Ensured top-level `{ campaigns: [...] }` and `{ task: {...} }` structures |
| Tasks needing user data               | Added `created_by` and `assigned_to` with nullify dependencies            |
| Enum defaults misbehaving             | Used `_default:` option in model                                          |
| Nested route confusion                | Split logic between `/campaigns/:id/tasks` and `/tasks/:id` endpoints     |
| RecordNotFound crashes                | Wrapped finds in `rescue_from` and returned proper `404` JSON             |

---

## Project Structure

```
goat-tech-code-test-be/
├── app/
│   ├── controllers/api/v1/
│   │   ├── campaigns_controller.rb
│   │   └── tasks_controller.rb
│   ├── models/
│   │   ├── campaign.rb
│   │   ├── task.rb
│   │   └── user.rb
├── db/
│   ├── migrate/
│   └── seeds.rb
├── config/
    ├── routes.rb
    └── initializers/cors.rb
```
---