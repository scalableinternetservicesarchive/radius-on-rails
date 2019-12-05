class Message < ApplicationRecord
    belongs_to :conversation
    default_scope -> { order(created_at: :asc) }
    validates_presence_of :body, :conversation_id, :user_id

    def message_time
        created_at.strftime("%m/%d/%y at %l:%M %p")
    end

    paginates_per 10
end
