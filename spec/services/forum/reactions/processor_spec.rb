# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forum::Reactions::Processor do
  subject { described_class.new(client: client, entity_type: 'forum', entity_id: entity.id, value: value) }

  let(:client) { create(:client) }
  let(:creator) { create(:client) }
  let(:entity) { create(:forum, creator: creator) }
  let(:value) { 1 }

  200.times do
    describe '#call' do
      context 'when all params are valid' do
        it 'creates a new reaction with the given value' do
          expect { subject.call }.to change { Forum::Reaction.count }.by(1)
          expect(Forum::Reaction.last.value).to eq value
        end # db clear

        it 'returns a Success monad' do
          expect(subject.call).to be_a Dry::Monads::Result::Success
        end
      end

      context 'when entity type is not allowed' do
        subject { described_class.new(client: client, entity_type: 'invalid_entity', entity_id: entity.id, value: value) }

        it 'returns a Failure monad' do
          expect(subject.call).to be_a Dry::Monads::Result::Failure
        end

        it 'returns an error message' do
          expect(subject.call.failure).to eq 'Entity invalid_entity is not allowed. Allowed entities: [:forum, :post]'
        end
      end

      context 'when entity with given ID is not found' do
        subject { described_class.new(client: client, entity_type: 'forum', entity_id: 999, value: value) }

        it 'returns a Failure monad' do
          expect(subject.call).to be_a Dry::Monads::Result::Failure
        end

        it 'returns an error message' do
          expect(subject.call.failure).to eq 'Forum with id=999 not found'
        end
      end

      context 'when client is not found' do
        subject { described_class.new(client: nil, entity_type: 'forum', entity_id: entity.id, value: value) }

        it 'returns a Failure monad' do
          expect(subject.call).to be_a Dry::Monads::Result::Failure
        end

        it 'returns an error message' do
          expect(subject.call.failure).to eq 'Client not found'
        end
      end

      context 'when value is not in range (-1..1)' do
        subject { described_class.new(client: client, entity_type: 'forum', entity_id: entity.id, value: 2) }

        it 'returns a Failure monad' do
          expect(subject.call).to be_a Dry::Monads::Result::Failure
        end

        it 'returns an error message' do
          expect(subject.call.failure).to eq 'Value is not in range (-1..1)'
        end
      end
    end
  end
end
