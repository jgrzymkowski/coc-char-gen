class CharacteristicSetsController < ApplicationController
  include CharacteristicSetsHelper

  def new
  end

  def create
    character = Character.find( params[:character_id] )
    if params[:characteristic_set][:arranged]
      puts '*'*100
      puts 'arranged'
      order = params[:characteristic_set][:order].split(',').map &:to_sym
      puts order.inspect
      character.create_characteristic_set( generate_arranged_stats( order ) ).save
    else
      puts '*'*100
      puts 'not arranged'
      character.create_characteristic_set( generate_random_stats ).save
    end

    redirect_to characters_path
  end

  def show
  end
end
