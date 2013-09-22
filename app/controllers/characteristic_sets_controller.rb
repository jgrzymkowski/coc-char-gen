class CharacteristicSetsController < ApplicationController
  include CharacteristicSetsHelper

  def new
  end

  def create
    character = Character.find( params[:character_id] )
    if params[:characteristic_set][:arranged] == 'true'
      order = params[:characteristic_set][:order].split(',').map &:to_sym
      puts order.inspect
      character.create_characteristic_set( generate_arranged_stats( order ) ).save
    else
      character.create_characteristic_set( generate_random_stats ).save
    end

    redirect_to new_character_skill_set_path character
  end

  def show
  end
end
