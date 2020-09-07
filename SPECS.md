# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    - AppController inherits from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database
    - Models inherit from ActiveRecord::Base
- [x] Include more than one model class (e.g. User, Post, Category)
    - Models include: Booking, Employee, Inventory, Item, ShiftHour, Task, Tenant, User, Venue
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    - has_many relationships:
        - User has_many Employees, Tenants, Venues, Tasks, Bookings, Inventories
        - Booking has_many ShiftHours, Employees (through ShiftHours)
        - Employee has_many ShiftHours, Bookings (through ShiftHours)
        - Inventory has_many Items
        - Tenant has_many Bookings
        - Venue has_many Bookings, Inventories, Items
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    - belongs_to relationships:
        - Booking belongs_to Venue, User, Tenant
        - Employee belongs_to User
        - Inventory belongs_to Venue
        - Item belongs_to Inventory
        - ShiftHour belongs_to Employee, Booking
        - Task belongs_to User
        - Tenant belongs_to User
        - Venue belongs_to User
- [x] Include user accounts with unique login attribute (username or email)
    - User table columns:
        - First Name
        - Last Name
        - Username
        - Password
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    - All belongs_to resources are CRUD-friendly
- [x] Ensure that users can't modify content created by other users
    - Authentication helper methods prevent accessing other resources
- [x] Include user input validations
    - Form validations present throughout using pattern-matching and conditionals
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
    - Sinatra Flash is utilized to display error messages
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    - See README.md, CONTRIBUTING.md, LICENSE.md

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
