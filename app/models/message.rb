class Message < ApplicationRecord
    belongs_to :conversation
    default_scope -> { order(created_at: :asc) }
    validates_presence_of :body, :conversation_id, :user_id

    paginates_per 10

    def message_time
        created_at.strftime("%m/%d/%y at %l:%M %p")
    end

    after_save do
        conversation.update_attribute(:updated_at, Time.now)
    end
end
