class EmployeeController < ApplicationController
    before '/employees*' do
        auth
    end
end
