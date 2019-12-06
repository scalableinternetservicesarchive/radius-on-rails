class Conversation < ApplicationRecord
    belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
    belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"

    has_many :messages, dependent: :destroy

    validates_uniqueness_of :sender_id, :scope => :recipient_id

    default_scope -> { order(updated_at: :desc) }

    scope :own, -> (current_user) do
        where("? in (conversations.sender_id, conversations.recipient_id)", current_user).order("updated_at DESC")
    end

    scope :between, -> (sender_id, recipient_id) do
        where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
    end

    paginates_per 10
end
