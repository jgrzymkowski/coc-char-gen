class NameMakerController < ApplicationController
  def first
    if params[:gender] =~ /f/
      render text: NameMaker.female_name
    elsif params[:gender] =~ /m/
      render text: NameMaker.male_name
    else
      render text: [NameMaker.female_name, NameMaker.female_name][(rand*2).to_i]
    end
  end

  def surname
    render text: NameMaker.surname
  end

  def city
    render text: NameMaker.city
  end
end