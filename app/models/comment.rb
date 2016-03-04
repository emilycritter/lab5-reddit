class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :post, :user, :comment_text, presence: true
end
