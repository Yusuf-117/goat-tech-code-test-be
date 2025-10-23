module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :set_campaign, only: [:show, :update, :destroy]

      def index
        # BUG 8: - use where. not find_by (returns 1 record)
        campaigns = if params[:status]
          Campaign.where(status: params[:status])
        else
          Campaign.all
        end
        
        # BUG 7: (didn't include tasks and task_count)
        campaigns = campaigns.includes(:tasks).map { |c| c.as_json.merge(task_count: c.tasks.count) }
        render json: { campaigns: campaigns }
      end

      def show
        # BUG 6: - wrap in a camapign:{} so we have access to res['campaign']['xyz']
        render json: { campaign: @campaign.as_json(include: :tasks) }
      end

      def create
        campaign = Campaign.new(campaign_params)

        if campaign.save
          render json: { campaign: campaign }, status: :created
        else
          render json: { errors: campaign.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @campaign.update(campaign_params)
          render json: { campaign: @campaign }
        else
          render json: { errors: @campaign.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @campaign.destroy
        head :no_content
      end

      private

      def set_campaign
        @campaign = Campaign.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Campaign not found' }, status: :not_found
      end

      def campaign_params
        # BUG 5: - allow status filter in req
        params.require(:campaign).permit(:name, :description, :status)
      end
    end
  end
end