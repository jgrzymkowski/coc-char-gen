class Dg::CampaignPolicy < ApplicationPolicy
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
      scope.where("id IN (?) OR id IN (?)", @user.dg_campaigns.map(&:id), @user.owned_dg_campaigns.map(&:id))
    end
  end
end
