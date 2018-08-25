class Coc::CampaignPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    @record.owners.include?(@user) || @record.users.include?(@user)
  end

  def destroy?
    @record.owners.include?(@user)
  end

  class Scope < Scope
    def resolve
      scope.where("id IN (?) OR id IN (?)", @user.campaigns.map(&:id), @user.owned_campaigns.map(&:id))
    end
  end
end
