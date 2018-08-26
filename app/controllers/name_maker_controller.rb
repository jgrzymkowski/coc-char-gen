class NameMakerController < ApplicationController
  def first
    if params[:game_system_id] == 'delta-green'
      if params[:gender] =~ /f/
        render text: NameMaker.female_name_2010
      elsif params[:gender] =~ /m/
        render text: NameMaker.male_name_2010
      else
        render text: [NameMaker.female_name_2010,
                      NameMaker.male_name_2010][(rand*2).to_i]
      end
    else
      if params[:gender] =~ /f/
        render text: NameMaker.female_name_1920
      elsif params[:gender] =~ /m/
        render text: NameMaker.male_name_1920
      else
        render text: [NameMaker.female_name_1920,
                      NameMaker.male_name_1920][(rand*2).to_i]
      end
    end
  end

  def surname
    if params[:game_system_id] == 'delta-green'
      render text: NameMaker.surname_2010
    else
      render text: NameMaker.surname_1920
    end
  end

  def city
    render text: NameMaker.city
  end

  def date_of_birth
    render text: NameMaker.date_of_birth
  end
end
