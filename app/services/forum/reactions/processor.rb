# frozen_string_literal: true

class Forum
  module Reactions
    class Processor
      ALLOWED_ENTITIES = [:forum, :post].freeze

      include Dry::Monads::Do.for(:call)
      include Dry::Monads::Result::Mixin
      extend Dry::Initializer

      option :client, required: true
      option :value, required: true
      option :entity_type, required: true
      option :entity_id, required: true

      def call
        klass = yield prepare_entity_klass
        entity = yield find_entity(klass)
        yield validate_params
        reaction = Forum::Reaction.find_or_create_by!(ratable: entity, client: @client)
        reaction.update!(value: @value)

        Success(reaction)
      end

      private

      def prepare_entity_klass
        if ALLOWED_ENTITIES.exclude?(@entity_type.to_sym)
          return Failure("Entity #{@entity_type} is not allowed. Allowed entities: #{ALLOWED_ENTITIES.to_s}")
        end

        klass =
          case @entity_type.to_sym
          when :forum
            Forum
          when :post
            Forum::Post
          end

        Success(klass)
      end

      def find_entity(klass)
        entity = klass.find_by(id: @entity_id)

        return Failure("#{klass.to_s} with id=#{@entity_id} not found") unless entity

        Success(entity)
      end

      def validate_params
        return Failure('Client not found') unless @client
        return Failure('Value is not in range (-1..1)') unless @value.in?(-1..1)

        Success(:ok)
      end
    end
  end
end
