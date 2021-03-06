class Coc::CampaignsController < ApplicationController
  expose(:campaign) do
    if params.permit(:id)[:id]
      Coc::Campaign.find(params.permit(:id)[:id])
    end
  end

  def new
  end

  def create
    attributes = params.require(:campaign).permit(:name)
    attributes.merge!(owner: current_user)
    @campaign = Coc::Campaign.new(attributes)

    authorize @campaign
    unless @campaign.valid?
      flash[:error] = @campaign.errors.full_messages.join '<br/>'
      render 'new'
    else
      @campaign.save!
      redirect_to coc_campaign_path @campaign
    end
  end

  def show
    authorize campaign
  end

  def destroy
    authorize campaign
    campaign.soft_delete

    redirect_to root_path
  end
end
