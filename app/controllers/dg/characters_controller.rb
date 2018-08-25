class Dg::CharactersController < ApplicationController
  expose(:character) { params.permit(:id)[:id] && Dg::Character.find(params.permit(:id)[:id]) }

  def create
  end
end
