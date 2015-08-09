class CharactersController < ApplicationController
  expose(:character)

  # TODO figure this out
  PLAYER_ATTRIBUTES = [:gender, :first_name, :last_name, :occupation, :degrees, :birthplace, :age, :income, :residence, :personal_description, :friends_and_family, :episodes_of_insanity, :wounds_and_injuries, :marks_and_scars, :cash, :savings, :property, :real_estate, :history]

  def new
  end

  def create
    @character = Character.new( params.require(:character).permit(PLAYER_ATTRIBUTES) )
    unless @character.valid?
      flash[:error] = @character.errors.full_messages.join '<br/>'
      render 'new'
    else
      @character.save!
      redirect_to character_path @character
    end
  end

  def show
    authorize character

    respond_to do |format|
      format.html {  }
      format.pdf do
        @filename = CharacterSheetGenerator.new( character ).generate
        send_file @filename, type: 'application/pdf'
      end
    end
  end

  def edit
    authorize character
  end

  def update
    authorize character

    if character.update_attributes( params.require(:character).permit(PLAYER_ATTRIBUTES) )
      render action: :show
    else
      render action: :edit
    end
  end

  def index
    @characters = policy_scope(Character)
  end

  def destroy
    authorize character

    character.destroy
    redirect_to characters_path
  end

end
