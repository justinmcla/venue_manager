require './config/environment'

use Rack::MethodOverride
use UserController
use VenueController
run ApplicationController

