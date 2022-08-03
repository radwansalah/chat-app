require 'securerandom'

module Api
  module V1
    class ApplicationsController < ApiController
      before_action :set_application, only: [:show, :update, :destroy]

      # GET /applications
      def index
        @applications = Application.all

        render json: @applications
      end

      # GET /applications/1
      def show
        render json: @application
      end

      # POST /applications
      def create
        uuid = SecureRandom.uuid
        is_existing = true

        while(is_existing)
          if Application.exists?(uuid)
            uuid = SecureRandom.uuid
          else
            is_existing = false
          end
        end

        @application = Application.new(application_params)
        @application.id = uuid

        if @application.save
          render json: @application, status: :created
        else
          render json: @application.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /applications/1
      def update
        if @application.update(application_params)
          render json: @application
        else
          render json: @application.errors, status: :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_application
          @application = Application.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def application_params
          params.require(:application).permit(:name)
        end
    end
  end
end
