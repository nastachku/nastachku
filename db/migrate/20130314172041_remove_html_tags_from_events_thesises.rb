class RemoveHtmlTagsFromEventsThesises < ActiveRecord::Migration
  def up
    UserEvent.transaction do
      UserEvent.find_each do |event|
        event.thesises = ActionController::Base.helpers.strip_tags(event.thesises)
        event.save!
      end
    end
  end

  def down
  end
end
