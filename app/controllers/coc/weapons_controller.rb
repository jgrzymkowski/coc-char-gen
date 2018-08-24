class Coc::WeaponsController < ApplicationController
  def edit
    @character = Coc::Character.find params[:character_id]
  end

  def update
    @character = Coc::Character.find params[:character_id]
    @character.weapon_ids = params[:weapon_list]
    @character.save!
    redirect_to coc_character_path @character
  end
end
