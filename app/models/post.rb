class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  attachment :photo
  validates :title, :vote_count, presence: true


end
