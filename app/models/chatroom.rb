class Chatroom < ApplicationRecord
    belongs_to :user
    has_many :messages
    validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25}
end
