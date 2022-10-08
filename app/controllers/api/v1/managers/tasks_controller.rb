# frozen_string_literal: true

module Api
  module V1
    module Managers
      class TasksController < BaseController
        before_action :obtain_task, only: :move

        def index
          tasks = Task.for_review

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
          when :finished
            operation = @task.mark_finished!

            return render json: { success: false, message: operation.failure }, status: 400 if operation.failure?
          else
            return render json: { success: false, message: 'Invalid State' }, status: 400
          end

          render(
            json: {
              success: true,
              **::TaskBlueprinter.render_as_hash(@task)
            }, status: 200
          )
        end

        private

        def resource
          Manager
        end

        def obtain_task
          @task ||= Task.find(params[:id])
        end
      end
    end
  end
end
