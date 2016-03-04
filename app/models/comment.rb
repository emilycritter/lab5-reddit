class Comment < ActiveRecord::Base
  belongs_to :post

  validates :post, :author, :comment_text, presence: true
end
