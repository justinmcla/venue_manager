require './config/environment'

use Rack::MethodOverride
use UserController
use EmployeeController
use VenueController
use TaskController
use BookingController
use TenantController
use InventoryController
use ItemController
run ApplicationController

