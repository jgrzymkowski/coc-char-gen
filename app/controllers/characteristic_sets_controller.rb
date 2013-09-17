class CharacteristicSetsController < ApplicationController
  def new
  end

  def create
    character = Character.new( params[:character] ).save
    redirect_to new_character_characteristic_set_path character_id: character.id
  end
end
