class Coc::CampaignPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    @record.owner == @user || @record.users.include?(@user)
  end

  def destroy?
    @record.owner == @user
  end

  class Scope < Scope
    def resolve
      scope.where("id IN (?) OR id IN (?)", @user.coc_campaigns.map(&:id), @user.owned_coc_campaigns.map(&:id))
    end
  end
end
