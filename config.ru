require './config/environment'

use Rack::MethodOverride
use UserController
use VenueController
use BookingController
run ApplicationController

