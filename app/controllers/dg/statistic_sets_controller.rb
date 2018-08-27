class Dg::StatisticSetsController < ApplicationController
  expose(:character) do
    params.permit(:character_id)[:character_id] &&
      Dg::Character.find(params.permit(:character_id)[:character_id])
  end

  def new
    authorize(Dg::StatisticSet, :new?)
  end

  def create
    authorize(Dg::StatisticSet, :create?)
    character.create_dg_statistic_set(statistic_set_params)
    redirect_to dg_character_path(character)
  end

  def statistic_set_params
    params.require(:statistic_set).permit(:strength,
                                          :constitution,
                                          :dexterity,
                                          :intelligence,
                                          :power,
                                          :charisma)
  end
end
