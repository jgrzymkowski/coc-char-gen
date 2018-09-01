class Dg::SkillSetPolicy < ApplicationPolicy
  def edit?
    true
  end

  def new?
    true
  end

  def create?
    true
  end
end
