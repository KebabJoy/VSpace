# frozen_string_literal: true

module Api
  module V1
    class TasksController < BaseController
      before_action :obtain_task, only: :move

      def index
        tasks = Task.where(client: current_member)

        render(
          json: {
            success: true,
            **::TaskBlueprinter.render_as_hash(tasks, root: :tasks),
          }, status: 200
        )
      end

      def move
        case params[:state]
        when :aborted
          @task.aborted!
        when :for_review
          @task.for_review!
        else
          return render json: { success: false, message: 'Invalid State' }, status: 400
        end

        render(
          json: {
            success: true,
            **::TaskBlueprinter.render_as_hash(@task),
          }, status: 200
        )
      end

      private

      def resource
        Client
      end

      def obtain_task
        @task ||= Task.find(params[:task_id])
      end
    end
  end
end
