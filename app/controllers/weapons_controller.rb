class WeaponsController < ApplicationController
  def edit
    @character = Character.find params[:character_id]
  end

  def update
    @character = Character.find params[:character_id]
    @character.weapon_ids = params[:weapon_list]
    @character.save!
    redirect_to character_path @character
  end
end