class Coc::CharacteristicSetsController < ApplicationController
  include Coc::CharacteristicSetsHelper

  def new
  end

  def create
    @character = Coc::Character.find( params[:character_id] )
    if params[:characteristic_set][:arranged] == 'true'
      order = params[:characteristic_set][:order].split(',').map &:to_sym
      @character.create_characteristic_set( generate_arranged_stats( order ) ).save
    else
      @character.create_characteristic_set( generate_random_stats ).save
    end
    redirect_to coc_character_characteristic_set_path( @character, @character.characteristic_set )
  end

  def show
    @character = Coc::Character.find( params[:character_id] )
  end
end
