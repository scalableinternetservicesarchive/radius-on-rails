class Post < ApplicationRecord
    belongs_to :user
    default_scope -> { order(created_at: :desc, id: :asc) }
    validates :content, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true
    has_many :likes, dependent: :destroy

    paginates_per 25
end
