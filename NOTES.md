A User...
    - has many Bookings
    - has many Items
    - has many LightFixtures, through Items
    - has many Speakers, through Items
    - has many Cables, through Items
    - has many Microphones, through Items
    - has many Properties, through Items
    - has many Costumes, through Items

A Booking...
    - belongs to a User

An Item...
    - belongs to a User

A LightFixture...
    - belongs to Items
    - belongs to a User, through Items

A Speaker...
    - belongs to Items
    - belongs to a User, through Items

A Cable...
    - belongs to Items
    - belongs to a User, through Items

A Microphone...
    - belongs to Items
    - belongs to a User, through Items

A Property...
    - belongs to Items
    - belongs to a User, through Items

A Costume...
    - belongs to Items
    - belongs to a User, through Items