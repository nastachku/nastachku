class AddPolymorphicToSlots < ActiveRecord::Migration
  def up
    add_column :slots, :event_type, :string
    Slot.transaction do
      Slot.includes(:event).find_each do |slot|
        slot.event_type = slot.event.class.model_name
        slot.save!
      end
    end
  end

  def down

  end
end
