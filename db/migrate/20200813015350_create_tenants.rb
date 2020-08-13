class CreateTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :tenants do |t|
      t.string :org_type
      t.string :org_name
      t.string :org_address
      t.string :org_city
      t.string :org_state
      t.string :org_zip
      t.string :poc_name
      t.string :poc_phone
      t.string :poc_email
    end
  end
end
