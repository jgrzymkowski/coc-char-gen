class CharacteristicSetsController < ApplicationController
  def new
  end

  def create
    #character = Character.new( params[:character] ).save
    redirect_to characters_path
  end

  def show
  end
end
