class SkillSetsController < ApplicationController
  def new
    @character = Character.find params[ :character_id ]
  end

end