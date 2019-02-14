class UsersController < ApplicationController
  expose(:user) do
    if params.permit(:id)[:id]
      User.find(params.permit(:id)[:id])
    else
      current_user
    end
  end

  def show
    @coc_campaigns = policy_scope(Coc::Campaign)
    @dg_campaigns = policy_scope(Dg::Campaign)
    authorize user
  end
end
