# frozen_string_literal: true

class CreateEventStoreEvents < ActiveRecord::Migration[6.1]
  def change
    create_table(:event_store_events_in_streams, id: :bigserial, force: false) do |t|
      t.string      :stream,      null: false
      t.integer     :position,    null: true
      t.references  :event,       null: false, type: :uuid, index: false
      t.datetime    :created_at,  null: false, type: :timestamp, precision: 6, index: true
    end
    add_index :event_store_events_in_streams, [:stream, :position], unique: true
    add_index :event_store_events_in_streams, [:stream, :event_id], unique: true

    create_table(:event_store_events, force: false) do |t|
      t.references  :event,       null: false, type: :uuid
      t.string      :event_type,  null: false
      t.jsonb       :metadata
      t.jsonb       :data,        null: false
      t.datetime    :created_at,  null: false
      t.datetime    :valid_at,    null: true
    end
  end
end
