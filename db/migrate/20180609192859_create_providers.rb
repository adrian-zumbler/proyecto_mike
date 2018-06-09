class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :person
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.date :birth_date
      t.string :street
      t.string :distrit
      t.string :postal_code
      t.string :state
      t.string :city
      t.string :rfc
      t.timestamps null: false
    end
  end
end
