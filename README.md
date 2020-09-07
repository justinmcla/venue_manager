# venue_manager

Sinatra/ActiveRecord MVC, CRUD app.

Features include:
    - Create venues
    - Create bookings
    - Manage tenants
    - Manage employees
    - Keep track of inventories
    - Task lists
    - Account management

Public access via: https://venuemanager.herokuapp.com

Requires a SESSON_SECRET on your local env. Generate a secure key using sysrandom in irb.

    $ irb
    $ require 'securerandom'
    $ SecureRandom.hex(64)

Echo this key to your shell rc file

    $ echo export SESSION_SECRET=0ca5... >> \.zshrc # or \.bashrc

To install, clone this repo locally, run

    $ rake db:migrate

and then

    $ shotgun
