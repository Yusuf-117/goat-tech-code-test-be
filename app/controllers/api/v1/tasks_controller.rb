module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_campaign, only: [:index, :create]
      before_action :set_task, only: [:show, :update, :destroy]

      
      def index
        builder = @campaign.tasks
        builder = builder.where(status: params[:status]) if params[:status]
        builder = builder.where(priority: params[:priority]) if params[:priority]
        
        render json: { tasks: builder.as_json(include: [:created_by, :assigned_to]) }
      end

      def show
        render json: { task: @task.as_json(include: [:created_by, :assigned_to]) }
      end

      def create
        task = @campaign.tasks.new(task_params)

        if task.save
          render json: { task: task.as_json(include: [:created_by, :assigned_to]) }, status: :created
        else
          render json: { errors: task.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: { task: @task.as_json(include: [:created_by, :assigned_to]) }
        else
          render json: { errors: @task.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def set_campaign
        @campaign = Campaign.find(params[:campaign_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Campaign not found' }, status: :not_found
      end

      def set_task
        @task = Task.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Task not found' }, status: :not_found
      end

      def task_params
        params.require(:task).permit( :title, :description, :status, :priority, :due_date, :campaign, :created_by_id, :assigned_to_id)
      end
    end
  end
end