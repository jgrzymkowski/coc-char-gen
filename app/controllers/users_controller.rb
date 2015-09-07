class UsersController < ApplicationController
  expose(:user) do
    if params.permit(:id)[:id]
      User.find(params.permit(:id)[:id])
    else
      current_user
    end
  end

  def show
    authorize user
  end
end
