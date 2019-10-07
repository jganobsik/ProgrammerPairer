class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :friends, array: true, default: []
      t.string :past_partners, array: true, default: []
      
      t.timestamps
    end
  end
end
