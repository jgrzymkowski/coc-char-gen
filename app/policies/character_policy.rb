class CharacterPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    @record.campaign.members.include?(@user)
  end

  def edit?
    @record.campiagn.owners.include?(@user) ||
      @record.user == @user
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
