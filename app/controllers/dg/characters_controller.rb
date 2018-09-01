class Dg::CharactersController < ApplicationController
  expose(:character) { params.permit(:id)[:id] && Dg::Character.find(params.permit(:id)[:id]) }
  expose(:campaign) { Dg::Campaign.find(params[:campaign_id]) }

  def new
  end

  def show
    authorize(character)

    respond_to do |format|
      format.html {  }
      format.pdf do
        @filename = Coc::CharacterSheetGenerator.new( character ).generate
        send_file @filename, type: 'application/pdf'
      end
    end
  end

  def create
    authorize(Dg::Character, :create?)
    character_attributes = character_params.merge({
      user: current_user,
      campaign: campaign
    })

    @character = Dg::Character.new(character_attributes)
    unless @character.valid?
      flash[:error] = @character.errors.full_messages.join '<br/>'
      render 'new'
    else
      @character.save!
      redirect_to dg_character_path @character
    end
  end

  def edit
    authorize(character)
  end

  def update
    authorize(character)

    if character.update_attributes(character_params)
      render action: :show
    else
      render action: :edit
    end
  end

  def character_params
    puts params.inspect
    params.require(:dg_character).permit(:first_name,
                                      :last_name,
                                      :alias,
                                      :profession,
                                      :employer,
                                      :nationality,
                                      :gender,
                                      :date_of_birth,
                                      :education_and_occupational_history)

  end
end
