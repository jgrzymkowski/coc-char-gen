class Coc::CharactersController < ApplicationController
  expose(:character) { params.permit(:id)[:id] && Coc::Character.find(params.permit(:id)[:id]) }

  # TODO figure this out
  PLAYER_ATTRIBUTES = [:campaign_id, :gender, :first_name, :last_name, :occupation, :degrees, :birthplace, :age, :income, :residence, :personal_description, :friends_and_family, :episodes_of_insanity, :wounds_and_injuries, :marks_and_scars, :cash, :savings, :property, :real_estate, :history]

  def create
    character_attributes = params.require(:character).permit(PLAYER_ATTRIBUTES)
    character_attributes.merge!(user: current_user)
    @character = Coc::Character.new(character_attributes)
    unless @character.valid?
      flash[:error] = @character.errors.full_messages.join '<br/>'
      render 'new'
    else
      @character.save!
      redirect_to coc_character_path @character
    end
  end

  def show
    authorize character

    respond_to do |format|
      format.html {  }
      format.pdf do
        @filename = Coc::CharacterSheetGenerator.new( character ).generate
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
    @characters = policy_scope(Coc::Character)
  end

  def destroy
    authorize character

    character.destroy
    redirect_to coc_characters_path
  end

end
