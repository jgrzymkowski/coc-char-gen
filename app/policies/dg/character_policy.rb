class Dg::CharacterPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    if @record.user == @user
      true
    else
      @record.campaign && @record.campaign.members.include?(@user)
    end
  end

  def edit?
    if @record.user == user
      true
    else
      @record.campaign && @record.campaign.owners.include?(@user)
    end
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  class Scope < Scope
    def resolve
      scope.where("campaign_id IN (?) OR campaign_id IN (?)", @user.campaigns.map(&:id), @user.owned_campaigns.map(&:id))
    end
  end
end
