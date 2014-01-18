class AddPersonalDataToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :residence, :string
    add_column :characters, :personal_description, :string
    add_column :characters, :family_and_friends, :text
    add_column :characters, :episodes_of_insanity, :string
    add_column :characters, :wounds_and_injuries, :string
    add_column :characters, :marks_and_scars, :string
    add_column :characters, :history, :text
    add_column :characters, :income, :string
    add_column :characters, :cash, :string
    add_column :characters, :savings, :string
    add_column :characters, :property, :string
    add_column :characters, :real_estate, :string
  end
end
