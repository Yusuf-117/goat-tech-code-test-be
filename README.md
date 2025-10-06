# Campaign Task Manager API - Debugging & Development Challenge

## Your Mission
This partially built Rails API acts as the server for the front end task repo (https://github.com/Ibex-CRM/goat-tech-code-test-fe). You need to:
1. **Fix bugs** in the existing Campaign functionality (9 bugs total)
2. **Build the Task model** from scratch (model, controller, routes, migrations)
3. **FRONT END** complete the front end repo (https://github.com/Ibex-CRM/goat-tech-code-test-fe)
4. **BONUS**: Add user relationships to tasks (created_by and assigned_to)

## Setup Instructions
```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
```

## Running Tests
```bash
bundle exec rspec
```

⚠️ **Expected:** Many tests will fail initially. This is normal!

## Current Status

### What Exists (But Has Bugs!)
✅ Campaign model - **HAS BUGS TO FIX**  
✅ Campaign controller - **HAS BUGS TO FIX**  
✅ User model - **WORKING CORRECTLY** (reference)  
✅ User controller - **WORKING CORRECTLY** (reference)  
✅ Test suite - **FAILING** (needs fixes and Task implementation)

### What's Missing (You Must Build!)
❌ Task model (create this from scratch)  
❌ Task controller (create this from scratch)  
❌ Task routes (add nested routes)  
❌ Task migrations (generate and run)  

---

## Phase 1: Fix Campaign Bugs (40 points)

There are **9 intentional bugs** in the Campaign implementation. Find (search "Bug") and fix them all!

### Expected Campaign Functionality

**Campaign Model:**
- `name` (string) - required, max 100 chars
- `description` (text) - optional
- `status` (enum: active, completed, archived) - default: active
- Has many tasks (with cascade delete)

**Campaign API Endpoints:**
- `GET /api/v1/campaigns` - List campaigns (with task_count and ?status= filter)
- `GET /api/v1/campaigns/:id` - Show campaign with tasks
- `POST /api/v1/campaigns` - Create campaign
- `PATCH /api/v1/campaigns/:id` - Update campaign (including status)
- `DELETE /api/v1/campaigns/:id` - Delete campaign and all tasks

### Known Bug Categories
🐛 Model validation issues  
🐛 Association problems  
🐛 Enum definition errors  
🐛 Routing misconfiguration  
🐛 Strong parameters incomplete  
🐛 Missing data in responses   
🐛 Query filtering broken   
🐛 Known CORS Error

**Hint:** Run the tests and read error messages carefully!

---

## Phase 2: Build Task Model (40 points)

Create a complete Task model from scratch.

### Task Model Requirements

**Attributes:**
```ruby
- title (string, required, max 200 chars)
- description (text, optional)
- status (enum: todo, in_progress, done, default: todo)
- priority (enum: low, medium, high, default: medium)
- due_date (date, optional)
- campaign_id (foreign key, required)
- created_at (timestamp)
- updated_at (timestamp)
```

## Phase 3: BONUS - User Relationships (+20 points)

There is a user model, but it's not being used... yet  
Perhaps you can find a use for it 😉

---

## Available Test Data

After running `rails db:seed`, you'll have:

**Users:**
- John 'Soap' MacTavish (soap@goat.com)
- Pioneer (pioneer@goat.com)
- Claptrap (claptrap@goat.com)

**Campaigns:**
- Burger Town - Mega Burger Launch (active)
- FICSIT Brand Awareness (active)
- Hyperion Launcher Launch (completed)

---

## Testing Your Work

### Run All Tests
```bash
bundle exec rspec
```

### Run Specific Test Files
```bash
bundle exec rspec spec/models/campaign_spec.rb
bundle exec rspec spec/requests/api/v1/campaigns_spec.rb
bundle exec rspec spec/models/task_spec.rb
bundle exec rspec spec/requests/api/v1/tasks_spec.rb
```

---

## Success Criteria

### Minimum Requirements (80 points)
✅ All 9 Campaign bugs fixed  
✅ All Campaign tests passing  
✅ Task model created with validations  
✅ Task controller with full CRUD  
✅ Task routes properly configured  
✅ Task tests passing  
✅ Tasks associated with Campaigns  
✅ Filtering works (status, priority)  
✅ CORS allows frontend connection  

### Bonus (20 points)
✅ User relationships implemented  
✅ created_by and assigned_to working  
✅ User data in Task responses  
✅ All bonus tests passing

---

## Time Estimate
- **Phase 1** (Fix bugs): 1-1.5 hours
- **Phase 2** (Build Task): 0.5-1.0 hours
- **Phase 3** (Bonus): 30-45 minutes
- **Total: 2-3 hours** (without bonus: 1.5-2.5 hours)

---

## Scoring Rubric

| Category | Points | Description                                       |
|----------|--------|---------------------------------------------------|
| Campaign bugs fixed | 40 | All 9 bugs resolved, tests passing                |
| Task model built | 40 | Complete model, controller, routes, tests passing |
| Code quality | 20 | Clean code, proper conventions, tests passing     |
| **Subtotal** | **100** | **Passing grade**                                 |
| **BONUS** User relationships | +20 |                                |
| **Maximum** | **120** | **Exceeds expectations**                          |

---

## Tips for Success

1. **Start with tests** - Run `bundle exec rspec` and read error messages
2. **Fix one bug at a time** - Don't try to fix everything at once
3. **Use the User model as reference** - It's built correctly
4. **Check validations** - Are they checking the right fields?
5. **Check associations** - has_many vs has_one, dependent: :destroy
6. **Check enums** - Syntax and default values
7. **Check routes** - Proper nesting and namespacing
8. **Check strong params** - Are all needed fields permitted?
9. **Check JSON responses** - Are they including all needed data?
10. **Test manually** - Use curl or Postman to verify endpoints work

---

## Questions?

If you get stuck:
1. Read the error messages carefully
2. Check the test files for expected behavior
3. Look at the User model/controller for reference
4. Use `rails console` to test models directly
5. Check Rails logs: `tail -f log/development.log`

Good luck! 🐛🔍🚀
