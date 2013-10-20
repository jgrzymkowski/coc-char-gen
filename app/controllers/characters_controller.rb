class CharactersController < ApplicationController
  def new
  end

  def create
    @character = Character.new( params[:character] )
    unless @character.valid?
      flash[:error] = @character.errors.full_messages.join '<br/>'
      render 'new'
    else
      @character.save!
      redirect_to character_path @character
    end
  end

  def show
    @character = Character.find( params[:id] )
    respond_to do |format|
      format.html {  }
      format.pdf do
        @filename = CharacterSheet.new( @character ).generate
        send_file @filename, type: 'application/pdf'
      end
    end
  end

  def edit
    @character = Character.find( params[:id] )
  end

  def update
    @character = Character.find( params[:id] )
    if @character.update_attributes( params[:character] )
      render action: :show
    else
      render action: :edit
    end
  end

  def index
    puts '$'*100
    @characters = Character.all
  end

  def destroy
    Character.find( params[:id] ).destroy
    redirect_to characters_path
  end

end
