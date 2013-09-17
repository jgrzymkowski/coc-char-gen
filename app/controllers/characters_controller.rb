class CharactersController < ApplicationController
  def new
  end

  def create
    character = Character.new( params[:character] )
    character.save
    redirect_to new_character_characteristic_set_path character_id: character.id
  end

  def show
    @character = Character.find( params[:id] )
  end

  def edit
    @character = Character.find( params[:id] )
  end

  def update
    @character = Character.find( params[:id] )
    if @character.update_attributes( params[:character] )
      redirect_to show
    else
      render 'edit'
    end
  end

  def index
    @characters = Character.all
  end

  def destroy
    Character.find( params[:id] ).destroy
    redirect_to :action => 'index'
  end

end
